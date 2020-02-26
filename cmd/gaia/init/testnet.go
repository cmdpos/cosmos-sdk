package init

// DONTCOVER

import (
	"encoding/json"
	"fmt"
	"net"
	"os"
	"path/filepath"

	"github.com/cosmos/cosmos-sdk/client/keys"

	"github.com/cosmos/cosmos-sdk/client"
	"github.com/cosmos/cosmos-sdk/cmd/gaia/app"
	"github.com/cosmos/cosmos-sdk/codec"
	srvconfig "github.com/cosmos/cosmos-sdk/server/config"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/auth"
	authtx "github.com/cosmos/cosmos-sdk/x/auth/client/txbuilder"
	"github.com/cosmos/cosmos-sdk/x/staking"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	tmconfig "github.com/tendermint/tendermint/config"
	"github.com/tendermint/tendermint/crypto"
	cmn "github.com/tendermint/tendermint/libs/common"
	"github.com/tendermint/tendermint/types"
	tmtime "github.com/tendermint/tendermint/types/time"

	"github.com/cosmos/cosmos-sdk/server"
)

var (
	flagNodeDirPrefix     = "node-dir-prefix"
	flagNumValidators     = "v"
	flagOutputDir         = "output-dir"
	flagNodeDaemonHome    = "node-daemon-home"
	flagNodeCliHome       = "node-cli-home"
	flagStartingIPAddress = "starting-ip-address"
	flagBaseport          = "base-port" // cmdpos
)

const nodeDirPerm = 0755

// get cmd to initialize all files for tendermint testnet and application
func TestnetFilesCmd(ctx *server.Context, cdc *codec.Codec) *cobra.Command {

	cmd := &cobra.Command{
		Use:   "testnet",
		Short: "Initialize files for a Gaiad testnet",
		Long: `testnet will create "v" number of directories and populate each with
necessary files (private validator, genesis, config, etc.).

Note, strict routability for addresses is turned off in the config file.

Example:
	gaiad testnet --v 4 --output-dir ./output --starting-ip-address 192.168.10.2
	`,
		RunE: func(_ *cobra.Command, _ []string) error {
			config := ctx.Config
			return initTestnet(config, cdc)
		},
	}

	cmd.Flags().Int(flagNumValidators, 4,
		"Number of validators to initialize the testnet with",
	)
	cmd.Flags().StringP(flagOutputDir, "o", "./mytestnet",
		"Directory to store initialization data for the testnet",
	)
	cmd.Flags().String(flagNodeDirPrefix, "node",
		"Prefix the directory name for each node with (node results in node0, node1, ...)",
	)
	cmd.Flags().String(flagNodeDaemonHome, "gaiad",
		"Home directory of the node's daemon configuration",
	)
	cmd.Flags().String(flagNodeCliHome, "gaiacli",
		"Home directory of the node's cli configuration",
	)
	cmd.Flags().String(flagStartingIPAddress, "192.168.0.1",
		"Starting IP address (192.168.0.1 results in persistent peers list ID0@192.168.0.1:46656, ID1@192.168.0.2:46656, ...)")

	cmd.Flags().String(
		client.FlagChainID, "", "genesis file chain-id, if left blank will be randomly created",
	)
	cmd.Flags().String(
		server.FlagMinGasPrices, fmt.Sprintf("0.000006%s", sdk.DefaultBondDenom),
		"Minimum gas prices to accept for transactions; All fees in a tx must meet this minimum (e.g. 0.01photino,0.001stake)",
	)

	cmd.Flags().Int(flagBaseport, 20056, "testnet base port") // cmdpos

	return cmd
}

/*
nodeDirName: [node0]
clientDir: [cache/node0/gaiacli]
addr: [eva1hg40dv5e237qy28vtyum52ygke32ez35syykpz]
secret: [depart neither they audit pen exile fire smart tongue express blanket burden culture shove curve address together pottery suggest lady sell clap seek whisper]

nodeDirName: [node1]
clientDir: [cache/node1/gaiacli]
addr: [eva1geyy4wtak2q9effnfhze9u4htd8yxxma0jmgl6]
secret: [country live width exotic behind mad belt bachelor later outside forget rude pudding material orbit shoot kind curve endless prosper make exotic welcome maple]

nodeDirName: [node2]
clientDir: [cache/node2/gaiacli]
addr: [eva1ztwjutkmfk30q8jr8444fyenkvwzrt2nczmgmn]
secret: [name vendor rose aunt lady bunker success picture rapid grace height antique judge abuse apology teach usual kangaroo fossil glimpse series spread rail polar]

{
  "name": "node3",
  "type": "local",
  "address": "eva1jt9vwuyfqmtphd2g36gyxmrwaga4tgekukysyp",
  "pubkey": "evapub1addwnpepqt8w9l20fhupwh7gc2wetzta8np3msl5d75tl0y6cmefshfrapfwsq2kmlp",
  "mnemonic": "motor always goose dune card scrub transfer veteran trick immense eight enrich jewel left denial cool acid profit good siren negative leopard early mechanic"
}
{
  "name": "node4",
  "type": "local",
  "address": "eva1yt78l96damcpge2wkgy988znl9svg9vdalqnws",
  "pubkey": "evapub1addwnpepq2g0gpsrkk2e8xdz3rfxhlx2j5a29y3uflnrmjchw9drfpnc4snpkn27una",
  "mnemonic": "future useful vanish scorpion ugly certain oxygen magnet chuckle elite hip fault two race curious wheat dish puzzle brick addict coil prefer stone wife"
}
{
  "name": "node5",
  "type": "local",
  "address": "eva1hxtpykp4x8u99hqkq5mayea5tgdpehcxy4v2k5",
  "pubkey": "evapub1addwnpepq2zl7mmvuqnp3gft5sndfgzza8rg6xrqzs54glhphx87fjwpn6q676h20gk",
  "mnemonic": "clerk universe city game fortune kitchen arrive regret donor wide borrow typical hold harbor actor raise inside truly nation ethics rally layer arena clump"
}
{
  "name": "node6",
  "type": "local",
  "address": "eva12lsf9l7ycdzj4gvsnwwxcaetrpwgjvj29feurs",
  "pubkey": "evapub1addwnpepqfwd8gl27l9wh5tzg3xl9xlftrr5jxhhtuxjenwnpeed25tmrm42qtev0w7",
  "mnemonic": "great inflict undo exchange sunny zone squeeze staff gadget style still plastic swear decorate tray still minimum plate elephant destroy cheese best ring learn"
}
{
  "name": "node7",
  "type": "local",
  "address": "eva1cltn9xun2ttsycn0eurfhd9dmnn85j9yj938n9",
  "pubkey": "evapub1addwnpepqtn3s5t0h5s05x2d8vp0xnq8wn99232fj7z4k7tze2s8ck5yqgkncjf7us0",
  "mnemonic": "tree metal excess fossil forget donor thought blast diary can flee rabbit cage float virtual ball object elbow ski brush tag dash faculty oak"
}
{
  "name": "node8",
  "type": "local",
  "address": "eva1ltrmr03j0r43ts794pqyg4pzxnnrpxnmnkuk9l",
  "pubkey": "evapub1addwnpepqtk6vvnksx3pzkd9sz43hzk32ykdy07v284e774ag5eu23sqdw6jqlncfns",
  "mnemonic": "bring shuffle net tonight elder help bar picnic sheriff trick ketchup panel boil guard void market more lion friend sick absent lazy camera envelope"
}
{
  "name": "node9",
  "type": "local",
  "address": "eva1v7dsqqn8ayvsfaa25gxd6hw56s3vmz8hxk2t6x",
  "pubkey": "evapub1addwnpepqvl9ryga3ysq4usfc3dhsx9j006306qkqs7rc2juc528rrzwgtgqg5fcvqd",
  "mnemonic": "park argue normal rally oven bus later problem siren way grape destroy cherry asset royal place stage expand rate monitor squirrel make wasp drastic"
}
{
  "name": "node10",
  "type": "local",
  "address": "eva173sclfedjwgf64kwymw5qscmc6vjg97l05zrml",
  "pubkey": "evapub1addwnpepqtrq0celc0mauagyq65a2wrww68zd0afvrn9ydhzx4ltl0ek343xx5l4yp8",
  "mnemonic": "biology bike beauty goat critic know flat trap deny special year human case february staff vast kid science math hybrid trial napkin space security"
}

 */

var (
	testnetAccountList = []string{
		"depart neither they audit pen exile fire smart tongue express blanket burden culture shove curve address together pottery suggest lady sell clap seek whisper",
		"country live width exotic behind mad belt bachelor later outside forget rude pudding material orbit shoot kind curve endless prosper make exotic welcome maple",
		"name vendor rose aunt lady bunker success picture rapid grace height antique judge abuse apology teach usual kangaroo fossil glimpse series spread rail polar",
		"motor always goose dune card scrub transfer veteran trick immense eight enrich jewel left denial cool acid profit good siren negative leopard early mechanic",
		"future useful vanish scorpion ugly certain oxygen magnet chuckle elite hip fault two race curious wheat dish puzzle brick addict coil prefer stone wife",
		"clerk universe city game fortune kitchen arrive regret donor wide borrow typical hold harbor actor raise inside truly nation ethics rally layer arena clump",
		"great inflict undo exchange sunny zone squeeze staff gadget style still plastic swear decorate tray still minimum plate elephant destroy cheese best ring learn",
		"tree metal excess fossil forget donor thought blast diary can flee rabbit cage float virtual ball object elbow ski brush tag dash faculty oak",
		"bring shuffle net tonight elder help bar picnic sheriff trick ketchup panel boil guard void market more lion friend sick absent lazy camera envelope",
		"park argue normal rally oven bus later problem siren way grape destroy cherry asset royal place stage expand rate monitor squirrel make wasp drastic",
		"biology bike beauty goat critic know flat trap deny special year human case february staff vast kid science math hybrid trial napkin space security",
		//"",
		//"",
		//"",
		//"",
	}
)

func getTestnetMnemonic(index int) string {
	if len(testnetAccountList) - 1 < index {
		return ""
	}

	return testnetAccountList[index]
}

func addAccount(address string, amount int64, accs []app.GenesisAccount) []app.GenesisAccount{
	addr, err := sdk.AccAddressFromBech32(address)
	if err != nil {
		return accs
	}
	accs = append(accs, app.GenesisAccount{
		Address: addr,
		Coins:   sdk.Coins{sdk.NewCoin(sdk.DefaultBondDenom, sdk.TokensFromTendermintPower(amount))},
	})
	return accs
}




func initTestnet(config *tmconfig.Config, cdc *codec.Codec) error {
	var chainID string

	outDir := viper.GetString(flagOutputDir)
	numValidators := viper.GetInt(flagNumValidators)

	chainID = viper.GetString(client.FlagChainID)
	if chainID == "" {
		chainID = "chain-" + cmn.RandStr(6)
	}

	monikers := make([]string, numValidators)
	nodeIDs := make([]string, numValidators)
	valPubKeys := make([]crypto.PubKey, numValidators)

	gaiaConfig := srvconfig.DefaultConfig()
	gaiaConfig.MinGasPrices = viper.GetString(server.FlagMinGasPrices)

	var (
		accs     []app.GenesisAccount
		genFiles []string
	)

	//{
	//	"mnemonic": "depart neither they audit pen exile fire smart tongue express blanket burden culture shove curve address together pottery suggest lady sell clap seek whisper",
	//	"address": "cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h",
	//	"pubkey": "cosmospub1addwnpepqvc67unsmp9r6vayp20xwcsmph0s765m63k43j3sagd24w98vsejz3n2vcw"
	//}
	//accs = addAccount("cosmos1hg40dv5e237qy28vtyum52ygke32ez35hm307h", 6 * 1e9, accs)

	//{
	//	"address": "cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0",
	//	"pubkey": "cosmospub1addwnpepqdcv2dpjxurg4kwca0e8mmf03pjerfe4vl29kfgvydpx9wype9z4xatgu3m",
	//	"mnemonic": "country live width exotic behind mad belt bachelor later outside forget rude pudding material orbit shoot kind curve endless prosper make exotic welcome maple"
	//}
	//accs = addAccount("cosmos1geyy4wtak2q9effnfhze9u4htd8yxxmagdw3q0", 9 * 1e9, accs)

	// generate private keys, node IDs, and initial transactions
	for i := 0; i < numValidators; i++ {
		nodeDirName := fmt.Sprintf("%s%d", viper.GetString(flagNodeDirPrefix), i)
		nodeDaemonHomeName := viper.GetString(flagNodeDaemonHome)
		nodeCliHomeName := viper.GetString(flagNodeCliHome)
		nodeDir := filepath.Join(outDir, nodeDirName, nodeDaemonHomeName)
		clientDir := filepath.Join(outDir, nodeDirName, nodeCliHomeName)
		gentxsDir := filepath.Join(outDir, "gentxs")

		config.SetRoot(nodeDir)

		err := os.MkdirAll(filepath.Join(nodeDir, "config"), nodeDirPerm)
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		err = os.MkdirAll(clientDir, nodeDirPerm)
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		monikers = append(monikers, nodeDirName)
		config.Moniker = nodeDirName

		ip, err := getIP(0, viper.GetString(flagStartingIPAddress)) // cmdpos
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		nodeIDs[i], valPubKeys[i], err = InitializeNodeValidatorFiles(config)
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		baseport := viper.GetInt(flagBaseport)
		port := baseport + i*100
		memo := fmt.Sprintf("%s@%s:%d", nodeIDs[i], ip, port) // cmdpos
		genFiles = append(genFiles, config.GenesisFile())

		buf := client.BufferStdin()
		prompt := fmt.Sprintf(
			"Password for account '%s' (default %s):", nodeDirName, app.DefaultKeyPass,
		)

		keyPass, err := client.GetPassword(prompt, buf)
		if err != nil && keyPass != "" {
			// An error was returned that either failed to read the password from
			// STDIN or the given password is not empty but failed to meet minimum
			// length requirements.
			return err
		}

		if keyPass == "" {
			keyPass = app.DefaultKeyPass
		}

		addr, secret, err := server.GenerateSaveCoinKey(clientDir, nodeDirName, keyPass, true, getTestnetMnemonic(i))
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		fmt.Printf("nodeDirName: [%s]\n", nodeDirName)
		fmt.Printf("clientDir: [%s]\n", clientDir)
		fmt.Printf("addr: [%s]\n", addr.String())
		fmt.Printf("secret: [%s]\n\n", secret)
		//fmt.Printf("%s\n", secret)

		info := map[string]string{"secret": secret}

		cliPrint, err := json.Marshal(info)
		if err != nil {
			return err
		}

		// save private key seed words
		err = writeFile(fmt.Sprintf("%v.json", "key_seed"), clientDir, cliPrint)
		if err != nil {
			return err
		}

		accTokens := sdk.TokensFromTendermintPower(1000)
		accStakingTokens := sdk.TokensFromTendermintPower(500)
		accs = append(accs, app.GenesisAccount{
			Address: addr,
			Coins: sdk.Coins{
				sdk.NewCoin(fmt.Sprintf("%stoken", nodeDirName), accTokens),
				sdk.NewCoin(sdk.DefaultBondDenom, accStakingTokens),
			},
		})

		valTokens := sdk.TokensFromTendermintPower(100)
		msg := staking.NewMsgCreateValidator(
			sdk.ValAddress(addr),
			valPubKeys[i],
			sdk.NewCoin(sdk.DefaultBondDenom, valTokens),
			staking.NewDescription(nodeDirName, "", "", ""),
			staking.NewCommissionMsg(sdk.NewDecWithPrec(5, 1), sdk.NewDecWithPrec(5, 1), sdk.NewDec(0)),
			sdk.OneInt(),
		)
		kb, err := keys.NewKeyBaseFromDir(clientDir)
		if err != nil {
			return err
		}
		tx := auth.NewStdTx([]sdk.Msg{msg}, auth.StdFee{}, []auth.StdSignature{}, memo)
		txBldr := authtx.NewTxBuilderFromCLI().WithChainID(chainID).WithMemo(memo).WithKeybase(kb)

		signedTx, err := txBldr.SignStdTx(nodeDirName, app.DefaultKeyPass, tx, false)
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		txBytes, err := cdc.MarshalJSON(signedTx)
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		// gather gentxs folder
		err = writeFile(fmt.Sprintf("%v.json", nodeDirName), gentxsDir, txBytes)
		if err != nil {
			_ = os.RemoveAll(outDir)
			return err
		}

		gaiaConfigFilePath := filepath.Join(nodeDir, "config/gaiad.toml")
		srvconfig.WriteConfigFile(gaiaConfigFilePath, gaiaConfig)
	}

	if err := initGenFiles(cdc, chainID, accs, genFiles, numValidators); err != nil {
		return err
	}

	err := collectGenFiles(
		cdc, config, chainID, monikers, nodeIDs, valPubKeys, numValidators,
		outDir, viper.GetString(flagNodeDirPrefix), viper.GetString(flagNodeDaemonHome),
	)
	if err != nil {
		return err
	}

	fmt.Printf("Successfully initialized %d node directories\n", numValidators)
	return nil
}

func initGenFiles(
	cdc *codec.Codec, chainID string, accs []app.GenesisAccount,
	genFiles []string, numValidators int,
) error {

	appGenState := app.NewDefaultGenesisState()
	appGenState.Accounts = accs

	appGenStateJSON, err := codec.MarshalJSONIndent(cdc, appGenState)
	if err != nil {
		return err
	}

	genDoc := types.GenesisDoc{
		ChainID:    chainID,
		AppState:   appGenStateJSON,
		Validators: nil,
	}

	// generate empty genesis files for each validator and save
	for i := 0; i < numValidators; i++ {
		if err := genDoc.SaveAs(genFiles[i]); err != nil {
			return err
		}
	}

	return nil
}

func collectGenFiles(
	cdc *codec.Codec, config *tmconfig.Config, chainID string,
	monikers, nodeIDs []string, valPubKeys []crypto.PubKey,
	numValidators int, outDir, nodeDirPrefix, nodeDaemonHomeName string,
) error {

	var appState json.RawMessage
	genTime := tmtime.Now()

	for i := 0; i < numValidators; i++ {
		nodeDirName := fmt.Sprintf("%s%d", nodeDirPrefix, i)
		nodeDir := filepath.Join(outDir, nodeDirName, nodeDaemonHomeName)
		gentxsDir := filepath.Join(outDir, "gentxs")
		moniker := monikers[i]
		config.Moniker = nodeDirName

		config.SetRoot(nodeDir)

		nodeID, valPubKey := nodeIDs[i], valPubKeys[i]
		initCfg := newInitConfig(chainID, gentxsDir, moniker, nodeID, valPubKey)

		genDoc, err := LoadGenesisDoc(cdc, config.GenesisFile())
		if err != nil {
			return err
		}

		nodeAppState, err := genAppStateFromConfig(cdc, config, initCfg, genDoc)
		if err != nil {
			return err
		}

		if appState == nil {
			// set the canonical application state (they should not differ)
			appState = nodeAppState
		}

		genFile := config.GenesisFile()

		// overwrite each validator's genesis file to have a canonical genesis time
		err = ExportGenesisFileWithTime(genFile, chainID, nil, appState, genTime)
		if err != nil {
			return err
		}
	}

	return nil
}

func getIP(i int, startingIPAddr string) (string, error) {
	var (
		ip  string
		err error
	)

	if len(startingIPAddr) == 0 {
		ip, err = server.ExternalIP()
		if err != nil {
			return "", err
		}
	} else {
		ip, err = calculateIP(startingIPAddr, i)
		if err != nil {
			return "", err
		}
	}

	return ip, nil
}

func writeFile(name string, dir string, contents []byte) error {
	writePath := filepath.Join(dir)
	file := filepath.Join(writePath, name)

	err := cmn.EnsureDir(writePath, 0700)
	if err != nil {
		return err
	}

	err = cmn.WriteFile(file, contents, 0600)
	if err != nil {
		return err
	}

	return nil
}

func calculateIP(ip string, i int) (string, error) {
	ipv4 := net.ParseIP(ip).To4()
	if ipv4 == nil {
		return "", fmt.Errorf("%v: non ipv4 address", ip)
	}

	for j := 0; j < i; j++ {
		ipv4[3]++
	}

	return ipv4.String(), nil
}
