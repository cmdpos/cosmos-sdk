package server

import (
	"errors"
	"net"
	"net/http"
	"os"

	"github.com/tendermint/tendermint/rpc/client"

	"github.com/tendermint/tendermint/node"

	"github.com/gorilla/mux"
	"github.com/rakyll/statik/fs"
	"github.com/spf13/viper"
	"github.com/tendermint/tendermint/libs/log"
	rpcserver "github.com/tendermint/tendermint/rpc/lib/server"

	"github.com/cosmos/cosmos-sdk/client/context"
	"github.com/cosmos/cosmos-sdk/codec"
	keybase "github.com/cosmos/cosmos-sdk/crypto/keys"

	// Import statik for light client stuff
	_ "github.com/cosmos/cosmos-sdk/client/lcd/statik"
)


// RestServer represents the Light Client Rest server
type RestServer struct {
	Mux     *mux.Router
	CliCtx  context.CLIContext
	KeyBase keybase.Keybase
	Cdc     *codec.Codec

	log         log.Logger
	listener    net.Listener
	fingerprint string
}

// NewRestServer creates a new rest server instance
func NewRestServer(cdc *codec.Codec, tmNode *node.Node) *RestServer {
	rootRouter := mux.NewRouter()
	cliCtx := context.NewCLIContext().WithCodec(cdc).WithAccountDecoder(cdc)
	logger := log.NewTMLogger(log.NewSyncWriter(os.Stdout)).With("module", "rest-server")

	cliCtx.Client = client.NewLocal(tmNode)
	cliCtx.TrustNode = true

	return &RestServer{
		Mux:    rootRouter,
		CliCtx: cliCtx,
		Cdc:    cdc,

		log: logger,
	}
}

// Start starts the rest server
func (rs *RestServer) Start(listenAddr string, maxOpen int) (err error) {
	//TrapSignal(func() {
	//	err := rs.listener.Close()
	//	rs.log.Error("error closing listener", "err", err)
	//})

	cfg := rpcserver.DefaultConfig()
	cfg.MaxOpenConnections = maxOpen

	rs.listener, err = rpcserver.Listen(listenAddr, cfg)
	if err != nil {
		return
	}
	return rpcserver.StartHTTPServer(rs.listener, rs.Mux, rs.log, cfg)
}

// ServeCommand will start the REST service as a blocking process. It
// takes a codec to create a RestServer object and a function to register all
// necessary routes.
func startRestServer(cdc *codec.Codec, registerRoutesFn func(*RestServer), tmNode *node.Node) error {
	rs := NewRestServer(cdc, tmNode)

	registerRoutesFn(rs)

	// Start the rest server and return error if one exists
	err := rs.Start(viper.GetString(FlagListenAddr),
		viper.GetInt(FlagMaxOpenConnections))

	return err

}

func (rs *RestServer) registerSwaggerUI() {
	statikFS, err := fs.New()
	if err != nil {
		panic(err)
	}
	staticServer := http.FileServer(statikFS)
	rs.Mux.PathPrefix("/swagger-ui/").Handler(http.StripPrefix("/swagger-ui/", staticServer))
}

func validateCertKeyFiles(certFile, keyFile string) error {
	if keyFile == "" {
		return errors.New("a key file is required")
	}
	if _, err := os.Stat(certFile); err != nil {
		return err
	}
	if _, err := os.Stat(keyFile); err != nil {
		return err
	}
	return nil
}
