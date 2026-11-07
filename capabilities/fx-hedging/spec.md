<div style="border-top: 6px solid #024731; border-bottom: 1px solid #B2B2B2; padding: 12px 0; margin-bottom: 24px; font-family: 'Open Sans', Helvetica, Arial, sans-serif;"> <div style="color: #024731; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; font-size: 0.85rem;">University of Hawaiʻi at Mānoa · Shidler College of Business</div> <div style="color: #000000; font-weight: 700; font-size: 1.25rem; margin-top: 4px;">FIN 321: International Finance and Securities</div> <div style="color: #525252; font-weight: 400; font-size: 0.95rem;">FX Transaction Hedging Project — Technical Specification</div> </div><!-- BRAND FORMATTING — applied per docs/_branding/design.json (v1.0.0) ┌─ Colors ─────────────────────────────────────────────────────────────┐ │ Primary green ........... #024731 RGB 2,71,49 Pantone 3435 C │ │ Primary black ........... #000000 RGB 0,0,0 Process Black │ │ Silver (secondary) ...... #B2B2B2 RGB 178,178,178 Cool Gray 5 C │ │ White (secondary) ....... #FFFFFF │ │ Neutral-600 (muted) ..... #525252 (secondary text, captions) │ │ UH-green 700 (hover) .... #013D26 (link hover, pressed state) │ │ UH-green 50 (tint) ...... #E6F2EF (callout backgrounds) │ │ Yellow (Excel only) ..... #FFFF00 (input highlight — not brand) │ ├─ Typography ─────────────────────────────────────────────────────────┤ │ Headings (web) .......... Open Sans Bold (H1/H2) / Semibold (H3/H4) │ │ Headings (print) ........ Avenir Bold │ │ Body (web) .............. Open Sans Regular │ │ Body (print) ............ Avenir Book │ │ Fallback stack .......... Helvetica, Arial, sans-serif │ │ Monospace ............... Consolas / ui-monospace │ │ Body minimum size ....... 10 pt (11–12 pt preferred for print) │ │ Leading ................. 3–5 pt greater than type size (print) │ │ Alignment ............... Flush left, ragged right │ ├─ Accessibility ──────────────────────────────────────────────────────┤ │ • ADA-compliant contrast ratios for ALL text and UI elements │ │ • No red body type │ │ • No layouts that are too dark for readability │ │ • No custom palettes or gradients outside the official brand │ └──────────────────────────────────────────────────────────────────────┘ Full brand standard: docs/_branding/design.json · Source: https://manoa.hawaii.edu/brand/ -->
U.S. Sawmill-Machinery Manufacturer — FX Transaction Hedge Model · Technical Specification
<span style="color:#024731; font-weight:700;">Technical specification</span> for the EUR receivable FX transaction hedge model — the named-range contract, calculation flow, and validation checks, precise enough that an AI or a colleague could build (or rebuild) the workbook from this document alone. This specification is the input for the AI-assisted Stage 3 build.
Assigned case: Scenario 5 — sawmill-machinery. The assigned business is a U.S. sawmill-machinery manufacturer that invoiced a Finnish lumber mill in euros.
Field	Value
Created by	Nicholas Bonilla
Updated by	Nicholas Bonilla
Date Created	2026-11-06
Date Updated	2026-11-06
Version	1.0
LLM Used (optional)	Claude (Sonnet 5.5) — validation planning
Role	Treasury Analyst
Audience	CFO / Director of Treasury
Companion Workbook	model.xlsx
1. Problem Statement
A U.S. sawmill-machinery manufacturer has invoiced a Finnish lumber mill and has a EUR receivable of €6,300,000 that will settle in 182 days. The exchange rate is quoted in USD per EUR, so if the euro depreciates against the US dollar before settlement, the company will receive fewer dollars when it converts the receivable. The objective is to compare no hedge, a forward hedge, a money-market hedge, and a EUR put option so Treasury can evaluate the trade-off between locking in USD proceeds and retaining upside if the euro appreciates.

2. Inputs (Known Variables)
All ten inputs below must be exposed as workbook named ranges. The values are indicative placeholders and will be replaced with live data at Stage 4. Record the actual source, access date, and quotation timestamp in the Notes & Assumptions tab.
2.1 Core Inputs
Name	Placeholder value	Unit	Source for Stage 4
FC_AMT	6,300,000	EUR	Case-provided receivable / company invoice records
S0_in	1.1609*	USD per EUR	Use EUR/USD market close on the day Stage 2 begins; record date and source; replace with live data at Stage 4
F0_in	1.1705	USD per EUR	Case-provided forward rate; verify with bank quotation
R_USD	4.28%*	Annual %, ACT/360	Find USD interest rate using the Stage 2 start-date market close; record date and source; replace with live data at Stage 4
R_FC	2.62%*	Annual %, ACT/360	Find EUR interest rate using the Stage 2 start-date market close; record date and source; replace with live data at Stage 4
K_PUT	1.1609	USD per EUR	Case says “at spot”; set equal to S0_in
K_CALL	1.1609	USD per EUR	Same at-spot convention; set equal to S0_in
PREM_PUT	0.0194	USD per EUR	Case-provided put premium; verify quotation in Stage 4
PREM_CALL	0.0296	USD per EUR	Case-provided call premium; verify quotation in Stage 4
T_DAYS	182	Days	Case-provided settlement horizon / contractual settlement date
Scenario identification: This is Scenario 5 (sawmill-machinery): a U.S. sawmill-machinery manufacturer invoiced a Finnish lumber mill. The assignment provides a business description, not a legal company name; do not invent one.
Input note: These values are indicative placeholders. The assignment instructions require S0_in, R_USD, and R_FC to be sourced from the market close on the date Stage 2 begins, with the date and source recorded; replace them with live data at Stage 4. The asterisk marks values that must be verified against that Stage 2 research record. Both interest-rate inputs use an ACT/360 basis. The case values are 4.28% for USD and 2.62% for EUR; do not substitute unrelated example rates from the template or other examples. All exchange rates and option premiums are quoted in USD per EUR.
2.2 Derived / Intermediate Values
Name	Description	Source
DF_USD	USD accumulation factor	1 + R_USD × T_DAYS / 360
DF_FC	EUR accumulation factor	1 + R_FC × T_DAYS / 360
S_T_grid	Ending spot-rate sensitivity grid	S0_in × (1 + shift), with shifts from -5% to +5% in 1% steps
USD_NO_HEDGE	Unhedged USD proceeds	FC_AMT × S_T
USD_FWD	Forward hedge proceeds	FC_AMT × F0_in
USD_MM	Money-market hedge proceeds	(FC_AMT / DF_FC) × S0_in × DF_USD
USD_PUT	Net put-hedge proceeds	FC_AMT × MAX(S_T, K_PUT) − FC_AMT × PREM_PUT
PUT_FLOOR	Minimum net proceeds under the put hedge	FC_AMT × K_PUT − FC_AMT × PREM_PUT
<span style="color:#024731;">Naming convention:</span> Use these standardized names consistently in Excel named ranges and in the Stage 3 AI build prompt. The ten core inputs in §2.1 are the required user-adjustable inputs.

3. Tab Architecture
The workbook must contain at least the following tabs. Each tab has a distinct purpose and should use consistent labels and formatting.
Tab Name	Purpose
Cover	Identifies the project, exposure, model purpose, and key headline results.
Legend_Key	Explains the workbook's cell-color convention and how to distinguish inputs, assumptions, formulas, and linked outputs.
Inputs	Holds the ten named inputs, placeholder values, units, sources, and Stage 4 update information.
Forward_Hedge	Calculates the USD proceeds locked in by the forward contract.
Money_Market_Hedge	Shows the three money-market steps: borrow EUR, convert to USD, and invest USD.
Option_Hedge	Calculates the EUR put's net proceeds and floor; documents the call payoff for the payable variant.
Sensitivity	Calculates all eleven ending-spot scenarios, compares the four receivable strategies, identifies the winner, and displays the chart.
Notes_Assumptions	Records assumptions, limitations, market-data sources, access dates, quotation timestamps, and validation results.
3.1 Workbook presentation
Use the supplied template's UH Mānoa / Shidler branding for the specification document. In the Excel workbook, use the Legend/Key consistently: yellow for input cells, blue for assumptions, black for formulas, and green for cross-tab links. The workbook should be readable, auditable, and consistent across tabs.

4. Assumptions & Constraints
1. Exposure: The U.S. sawmill-machinery manufacturer receives EUR 6,300,000 from a Finnish lumber mill in 182 days.
2. Quote convention: All exchange rates are USD per EUR. A higher S_T means the euro has appreciated against the dollar.
3. Day-count convention: Both R_USD and R_FC use ACT/360. The money-market accumulation factors therefore use rate × T_DAYS / 360.
4. Transaction costs: Transaction costs, bank fees, bid-ask spreads, and taxes are excluded from the initial comparison. The Notes tab should identify these as limitations.
5. Option premium: The premium is paid upfront in USD. For this assignment's sensitivity calculation, deduct FC_AMT × PREM_PUT from the option's settlement proceeds, as shown in the professor's instructions. Do not add a future-value adjustment unless the instructor later requests it.
6. Strike convention: Both K_PUT and K_CALL are initially set at spot, equal to S0_in.
7. Parity: The money-market hedge and forward hedge should produce approximately equal USD proceeds under covered interest-rate parity. A small difference can arise from rounding or from the supplied market quotes.
8. Scenario method: The model uses deterministic spot-rate scenarios; it does not assign probabilities or model implied volatility.
9. Scope: The main comparison is for a EUR receivable. The call option is documented for completeness and for a possible payable version, not treated as a fourth receivable hedge.

5. Calculation Flow
Use the standardized names below. Do not use individual Excel cell addresses in the specification or in the formulas supplied to the AI builder.
Step 1 — Derived inputs
* DF_USD = 1 + R_USD × T_DAYS / 360
* DF_FC = 1 + R_FC × T_DAYS / 360
These are the accumulation factors used for the USD and EUR legs of the money-market hedge.
Step 2 — Forward hedge
The U.S. sawmill-machinery manufacturer sells the EUR receivable forward and locks in the quoted forward rate.
USD_FWD = FC_AMT × F0_in
Using the case inputs:
6,300,000 × 1.1705 = $7,374,150
The forward proceeds are fixed and do not change across the ending spot-rate scenarios.
Step 3 — Money-market hedge (three separate steps)
1. Borrow euros: Borrowed_EUR = FC_AMT / (1 + R_FC × T_DAYS / 360). This is sized so the EUR borrowing plus interest is repaid exactly by the EUR receivable at settlement.
2. Convert to dollars: USD_Today = Borrowed_EUR × S0_in.
3. Invest the dollars: USD_MM = USD_Today × (1 + R_USD × T_DAYS / 360). The USD investment is the money-market hedge's settlement proceeds.
Expected results using the supplied case inputs are approximately €6,217,644 borrowed, $7,218,063 converted today, and $7,374,246 at settlement. Small differences may result from display rounding.
Step 4 — Interest-rate parity check
Calculate the implied forward rate:
Implied_Forward = S0_in × (1 + R_USD × T_DAYS / 360) / (1 + R_FC × T_DAYS / 360)
The implied forward should be close to F0_in. The forward proceeds and money-market proceeds should also be close. Report the difference in USD and the percentage difference so the reviewer can assess the parity check.
Step 5 — Put option hedge
The EUR put gives the company the right to sell EUR at K_PUT. For each ending spot rate S_T, calculate:
USD_PUT = FC_AMT × MAX(S_T, K_PUT) − FC_AMT × PREM_PUT
The put therefore creates a minimum net USD proceeds floor of:
PUT_FLOOR = FC_AMT × K_PUT − FC_AMT × PREM_PUT
If S_T is below K_PUT, the strike protects the conversion rate. If S_T is above K_PUT, the company benefits from the higher spot rate, less the premium.
Step 6 — Call option payoff
For completeness, the standalone EUR call payoff is:
Call_Net_Payoff = FC_AMT × MAX(S_T − K_CALL, 0) − FC_AMT × PREM_CALL
A call on EUR is generally relevant to a future EUR payable because it protects against EUR appreciation. It is not used as a receivable hedge in the main sensitivity comparison.
Step 7 — Sensitivity table
For each S_T in S_T_grid, calculate:
Strategy / Output	Formula
Unhedged proceeds	USD_NO_HEDGE = FC_AMT × S_T
Forward proceeds	USD_FWD = FC_AMT × F0_in
Money-market proceeds	USD_MM = (FC_AMT / DF_FC) × S0_in × DF_USD
Put proceeds	USD_PUT = FC_AMT × MAX(S_T, K_PUT) − FC_AMT × PREM_PUT
Best strategy	Identify the largest of USD_NO_HEDGE, USD_FWD, USD_MM, and USD_PUT
The winner label must be formula-driven. If two strategies tie within the workbook's rounding precision, the workbook should display a tie or apply a clearly documented tie rule.

6. Sensitivity Plan
S_T will run from 0.95 × S0_in to 1.05 × S0_in in 1% increments. This produces exactly eleven scenarios: -5%, -4%, -3%, -2%, -1%, 0%, +1%, +2%, +3%, +4%, and +5%.
For every scenario, calculate and compare the proceeds from:
1. Unhedged EUR conversion.
2. Forward hedge.
3. Money-market hedge.
4. EUR put option hedge.
Create one line chart with ending spot rate S_T on the horizontal axis and USD proceeds on the vertical axis. The chart should show the unhedged proceeds rising with the euro, the forward and money-market proceeds as nearly horizontal lines, and the put strategy's floor with upside participation above the strike. The chart and table should help the CFO see where the preferred strategy changes as the ending spot rate crosses the forward rate and put strike.
The supplied scenario screenshot indicates that the forward is the best strategy from -5% through 0%, while remaining unhedged is best from +1% through +5%. The final workbook must recalculate the winner from formulas rather than hardcode these labels.

7. Validation Rules
The finished workbook must pass all of the following checks. These are requirements for the Stage 3 build and audit; do not mark a check complete until the workbook has actually passed it.
* Input completeness: All ten names in §2.1 exist as named ranges and have the correct values and units.
* Rate basis: Both interest-rate inputs are annual rates using ACT/360; the calculation formulas divide by 360.
* Forward proceeds: USD_FWD equals FC_AMT × F0_in; expected result is $7,374,150.
* EUR borrowing: Borrowed_EUR × (1 + R_FC × T_DAYS / 360) equals FC_AMT, subject only to rounding.
* Money-market proceeds: The three-step calculation produces approximately $7,374,246 using the supplied inputs.
* Parity: The forward and money-market proceeds agree within 0.05% of forward proceeds. Show the absolute and percentage difference.
* Put floor: At S_T ≤ K_PUT, put proceeds equal FC_AMT × K_PUT − FC_AMT × PREM_PUT. At S_T > K_PUT, proceeds equal FC_AMT × S_T − FC_AMT × PREM_PUT.
* Sensitivity grid: Exactly eleven scenarios are present, beginning at 0.95 × S0_in, ending at 1.05 × S0_in, and increasing in 1% increments.
* Formula integrity: Every calculated output is formula-driven, not a manually typed result.
* Error check: No formula cells display Excel errors such as #DIV/0!, #VALUE!, #REF!, or #NAME?.
* Dynamic behavior: Changing an input updates all dependent calculations, the sensitivity table, winner labels, and chart.
* Presentation: Workbook colors match the Legend/Key: yellow inputs, blue assumptions, black formulas, and green cross-tab links.
7.1 Auditability Checklist
* All ten required inputs have standardized named ranges.
* Every formula uses named ranges rather than hardcoded cell addresses.
* Borrowed EUR plus interest equals the EUR receivable.
* Forward and money-market proceeds agree within 0.05%.
* Put payoff and floor are correct at and below the strike.
* Sensitivity grid contains eleven symmetric scenarios.
* No formula errors exist.
* All calculated outputs are formulas, not typed numbers.
* Notes tab records Stage 4 data sources and access dates.
* Cell colors follow the Legend/Key.

8. Outputs
The workbook must produce the following named outputs and presentation items.
Output Name	Description	Purpose
USD_FWD / Forward Proceeds	USD proceeds locked in by the forward contract	Forward benchmark
Borrowed_EUR	EUR borrowed at inception for the money-market hedge	Money-market Step 1
USD_Today	USD obtained by converting borrowed EUR at spot	Money-market Step 2
USD_MM / Money-Market Proceeds	USD investment proceeds at settlement	Money-market benchmark
Implied_Forward	Forward rate implied by spot and the two interest rates	Covered interest parity check
PUT_FLOOR / Put Floor	Minimum net proceeds after the put premium	Downside-protection measure
USD_NO_HEDGE / Unhedged Proceeds	USD proceeds from converting the receivable at S_T	Unhedged benchmark
USD_PUT / Put Proceeds	Net USD proceeds under the put hedge at each S_T	Option strategy comparison
Sensitivity_Table	Eleven scenarios showing all four strategies and the winning strategy	Main scenario analysis
Sensitivity_Chart	Line chart comparing the four strategies across ending spot rates	CFO decision support
8.1 Base-case reference values
At S_T = S0_in, the supplied case values and the professor's upfront-premium convention imply the following approximate reference results. Confirm the calculations in the completed workbook before treating them as passed audit checks.
Strategy	USD Proceeds
No hedge	$7,313,670
Forward	$7,374,150
Money market	$7,374,246
Put option	$7,191,450
The put proceeds are calculated as FC_AMT × K_PUT − FC_AMT × PREM_PUT. The base-case table is a regression reference, not a substitute for formula-driven workbook outputs.

9. Writing a Strong Specification
<span style="color:#024731; font-weight:600;">The spec should read like a handoff document, not a lab notebook.</span>
* Communicate like a professional: Use clear, structured language and explain the financial purpose of each hedge.
* Think one stage ahead: This specification feeds directly into the Stage 3 AI build prompt and the Stage 5 decision memo.
* Be internally consistent: Use the same variable names, units, quote convention, and premium treatment throughout.
* Be reproducible: Another Treasury analyst or AI should be able to rebuild the model from this specification alone.
* Be reflective: Section 6 and the audit checklist should identify real limitations and tests, not claim unverified success.
* Be executive-relevant: The CFO should understand what the model compares and how the sensitivity analysis informs the hedging decision.

10. How This Sets Up Stages 3–5
What's Written in Stage 2	What It Enables in Stages 3–5
Ten standardized named inputs with units and Stage 4 sources	AI uses consistent variable names and the analyst can replace placeholders with sourced data
Workbook tab architecture	Stage 3 build has a defined workbook structure
Step-by-step forward, money-market, parity, and option calculations	AI generates auditable hedge formulas
Sensitivity plan with eleven scenarios and four strategies	Stage 3 produces the required table and chart
Validation rules and audit checklist	Stage 3 formulas can be tested systematically
Outputs and base-case reference values	Stage 3 and Stage 4 have regression checkpoints for the refined model

Appendix A — Change Log
Version	Date	Author	Change
0.1	2026-11-06	Nicholas Bonilla	Initial draft
