# Stage 4 Market Data Memo — Scenario 5 (Sawmill-Machinery)

**Date retrieved:** 2026-11-20  
**Scenario:** U.S. sawmill-machinery manufacturer; EUR receivable from Finnish lumber mill  
**Receivable:** €6,300,000  
**Settlement horizon:** 182 days (case-provided)

## Market inputs populated

| Named input | Value | Source / observation | Timestamp / date | Choice and limitation |
|---|---:|---|---|---|
| `S0_in` | 1.0990 USD/EUR | ECB euro reference rate | 2026-11-20; ECB daily reference rate, normally published around 16:00 CET | Official reference rate, not a transaction bid/ask quote. |
| `R_USD` | 4.51% | U.S. 1-year Treasury yield | 2026-11-20 | Annual government-yield proxy, not a matched 182-day USD deposit rate. |
| `R_FC` | 2.995% | Germany 1-year government bond yield | 2026-11-20 | EUR government-yield proxy; Germany chosen as a euro-area sovereign proxy, not a matched 182-day EUR deposit rate. |
| `F0_in` | 1.1705 USD/EUR | Scenario value from Stage 2 specification | Case input; not independently sourced on 2026-11-20 | Retained as the scenario forward. **No bank quote was obtained**, so it must not be described as a live bank quote. |
| `K_PUT`, `K_CALL` | 1.0990 USD/EUR | At-spot convention | Set equal to `S0_in` | Scenario convention. |
| `PREM_PUT` | 0.0194 USD/EUR | Scenario-provided | Stage 2 assumption | Retained; not a live option quote. |
| `PREM_CALL` | 0.0296 USD/EUR | Scenario-provided | Stage 2 assumption | Retained; not a live option quote. |
| `FC_AMT` | €6,300,000 | Scenario | Case-provided | Unchanged. |
| `T_DAYS` | 182 | Scenario | Case-provided | Unchanged. |

## Sources

- ECB, euro reference exchange rates: https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html
- U.S. Federal Reserve, H.15 Selected Interest Rates: https://www.federalreserve.gov/releases/h15/
- Germany 1-year bond yield historical data (Investing.com): https://www.investing.com/rates-bonds/germany-1-year-bond-yield-historical-data

## Rate-selection rationale

The U.S. 1-year Treasury yield and Germany 1-year government yield are transparent sovereign-yield proxies for the USD and EUR rates. They are not directly comparable to matched-term money-market deposit/borrowing rates and do not perfectly match the 182-day transaction horizon. This limitation is disclosed rather than hidden.

## CIP calculation and check

Using the workbook convention and ACT/360 with 182 days:

\[
F_{CIP}=S_0\times\frac{1+R_{USD}\times182/360}{1+R_{EUR}\times182/360}
\]

- `F_CIP` = **1.107292 USD/EUR**
- Scenario `F0_in` = **1.1705 USD/EUR**
- Quote less CIP = **0.063208 USD/EUR** (**5.71%** of CIP)
- Forward proceeds at scenario quote = **$7,374,150.00**
- Money-market proceeds using selected proxy rates = **$6,975,938.80**
- Money-market less forward proceeds = **$-398,211.20** (**-5.40%** of forward proceeds)

The difference is material. The rates are government-yield proxies, while the scenario forward is not an independently verified market quote; maturities and instrument bases may also differ. The check is therefore a documented discrepancy, **not something to “fix” by changing an input**. A true market comparison requires a bank forward quote for the same settlement date and matched-term USD/EUR funding rates.

## Option assumptions

The scenario put/call premiums were retained because the Stage 4 instructions say to keep scenario-provided premiums and note that retail-accessible option quotes may be unreliable. They are assumptions, not observed live market premiums.

## Workbook checks

- Inputs were populated through the named-range input cells only.
- The sensitivity table is formula-driven and is intended to recalculate around the new spot.
- The workbook is flagged to recalculate on opening.
- The parity difference and sensitivity/chart should be verified in Excel after recalculation.
- **FX Hedging Lab cross-check: pending.** I have not independently run the Lab with these inputs; do not mark this checklist item complete until you compare the Lab outputs and resolve any discrepancy.
- The workbook remains a draft pending your manual formula/error inspection and Excel recalculation.

## Honest status / outstanding items

1. Obtain a same-date, same-settlement-date bank forward quote if the instructor expects a live quote; replace `F0_in` only with a verified quote and record source/time.
2. Compare the workbook against the FX Hedging Lab and document the resolution.
3. Open in Excel, confirm formulas calculate, chart/sensitivity refresh, and no error cells exist.
4. Do not claim that the scenario forward or option premiums are live market quotations.

## FX Hedging Lab formula-equivalent cross-check

The published FX Hedging Lab page documents the same forward, three-step money-market, covered-interest-parity, and ±5% sensitivity formulas as the workbook. I independently recalculated those outputs using the populated Stage 4 inputs to compare formula results. I could not directly interact with the Lab's live input controls in this environment, so this is a formula-equivalent cross-check, **not a claim that the Lab UI was entered and observed**.

| Output | Workbook / Lab formula-equivalent result |
|---|---:|
| Forward proceeds (`FC_AMT × F0_in`) | $7,374,150.00 |
| EUR borrowed (`FC_AMT / (1 + R_FC × T/360)`) | €6,206,032.06 |
| USD converted today | $6,820,429.23 |
| USD invested / money-market proceeds | $6,975,938.80 |
| CIP-implied forward | 1.107291874 USD/EUR |
| Put net floor (`FC_AMT × K_PUT − FC_AMT × PREM_PUT`) | $6,801,480.00 |
| Call net payoff at base spot | -$186,480.00 |
| MM less forward | -$398,211.20 |

The calculations reconcile to the workbook formulas. The parity check remains a FAIL: the retained scenario forward (1.1705) differs materially from the CIP-implied forward (1.107292). No inputs were changed to force a pass.

The 11 sensitivity spots are 1.04405 through 1.15395 USD/EUR in 1% steps around 1.0990. Forward and money-market proceeds remain flat; unhedged proceeds rise with spot; the EUR put remains at its net floor below strike and participates above strike after premium.
