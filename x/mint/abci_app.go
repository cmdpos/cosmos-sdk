package mint

import (
	"fmt"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

// Inflate every block, update inflation parameters once per hour
func BeginBlocker(ctx sdk.Context, k Keeper) {

	// fetch stored minter & params
	minter := k.GetMinter(ctx)
	params := k.GetParams(ctx)

	fmt.Printf("params: %v\n", params)

	// recalculate inflation rate
	totalSupply := k.sk.TotalTokens(ctx)
	bondedRatio := k.sk.BondedRatio(ctx)


	fmt.Printf("totalSupply: %v\n", totalSupply)
	fmt.Printf("bondedRatio: %v\n", bondedRatio)

	minter.Inflation = minter.NextInflationRate(params, bondedRatio)

	//fmt.Printf("minter.Inflation: %v\n", minter.Inflation)

	minter.AnnualProvisions = minter.NextAnnualProvisions(params, totalSupply)
	k.SetMinter(ctx, minter)
	fmt.Printf("minter: %+v\n", minter)

	// mint coins, add to collected fees, update supply
	mintedCoin := minter.BlockProvision(params)

	fmt.Printf("mintedCoin: %v\n", mintedCoin)

	k.fck.AddCollectedFees(ctx, sdk.Coins{mintedCoin})
	k.sk.InflateSupply(ctx, mintedCoin.Amount)

}
