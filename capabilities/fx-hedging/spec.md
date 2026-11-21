<div style="border-top: 6px solid #024731; border-bottom: 1px solid #B2B2B2; padding: 12px 0; margin-bottom: 24px; font-family: 'Open Sans', Helvetica, Arial, sans-serif;">
  <div style="color: #024731; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; font-size: 0.85rem;">University of Hawaiʻi at Mānoa · Shidler College of Business</div>
  <div style="color: #000000; font-weight: 700; font-size: 1.25rem; margin-top: 4px;">FIN 321: International Finance and Securities</div>
  <div style="color: #525252; font-weight: 400; font-size: 0.95rem;">FX Transaction Hedging Project — Technical Specification</div>
</div><!--
BRAND FORMATTING — applied per docs/_branding/design.json (v1.0.0)
  ┌─ Colors ─────────────────────────────────────────────────────────────┐
  │ Primary green ........... #024731  RGB 2,71,49    Pantone 3435 C     │
  │ Primary black ........... #000000  RGB 0,0,0      Process Black      │
  │ Silver (secondary) ...... #B2B2B2  RGB 178,178,178 Cool Gray 5 C     │
  │ White (secondary) ....... #FFFFFF                                    │
  │ Neutral-600 (muted) ..... #525252  (secondary text, captions)        │
  │ UH-green 700 (hover) .... #013D26  (link hover, pressed state)       │
  │ UH-green 50 (tint) ...... #E6F2EF  (callout backgrounds)             │
  │ Yellow (Excel only) ..... #FFFF00  (input highlight — not brand)     │
  ├─ Typography ─────────────────────────────────────────────────────────┤
  │ Headings (web)  .......... Open Sans Bold (H1/H2) / Semibold (H3/H4) │
  │ Headings (print)  ........ Avenir Bold                               │
  │ Body (web)  .............. Open Sans Regular                         │
  │ Body (print)  ............ Avenir Book                               │
  │ Fallback stack  .......... Helvetica, Arial, sans-serif              │
  │ Monospace  ............... Consolas / ui-monospace                   │
  │ Body minimum size  ....... 10 pt (11–12 pt preferred for print)      │
  │ Leading  ................. 3–5 pt greater than type size (print)     │
  │ Alignment  ............... Flush left, ragged right                  │
  ├─ Accessibility ──────────────────────────────────────────────────────┤
  │ • ADA-compliant contrast ratios for ALL text and UI elements         │
  │ • No red body type                                                   │
  │ • No layouts that are too dark for readability                       │
  │ • No custom palettes or gradients outside the official brand         │
  └──────────────────────────────────────────────────────────────────────┘
  Full brand standard: docs/_branding/design.json · Source: https://manoa.hawaii.edu/brand/
--># FX Transaction Hedging Project — Technical Specification

**Course:** FIN 321: International Finance and Securities, University of Hawaiʻi at Mānoa / Shidler College of Business  
**Assigned case:** Scenario 5 — sawmill-machinery  
**Author:** Nicholas Bonilla  
**Updated:** 2026-11-20  
**Version:** 1.1 — Stage 2 review corrections

## 1. Problem Statement

A U.S. sawmill-machinery manufacturer has invoiced a Finnish lumber mill and has a EUR receivable of €6,300,000 settling in 182 days. Because exchange rates are quoted in USD per EUR, a weaker euro at settlement reduces the USD proceeds received when the receivable is converted.

The model compares no hedge, a forward hedge, a money-market hedge, and a EUR put option so Treasury can evaluate downside protection, locked-in proceeds, and upside participation.

## 2. Inputs (Known Variables)

All ten inputs below must be exposed as workbook named ranges. The current values are indicative placeholders; Stage 4 will replace market-data placeholders with researched inputs. Record each actual source, access date, and quotation timestamp in `Notes_Assumptions`.

| Name | Placeholder | Unit | Stage 4 source plan |
|---|---:|---|---|
| `FC_AMT` | 6,300,000 | EUR | Case receivable / invoice records |
| `S0_in` | 1.1609 | USD per EUR | Indicative placeholder; verify against a documented EUR/USD spot source and timestamp |
| `F0_in` | 1.1705 | USD per EUR | Case forward placeholder; verify bank quotation |
| `R_USD` | 4.28% | Annual rate, ACT/360 | Placeholder; document the chosen USD instrument and source, e.g. 6-month Treasury rate from the Federal Reserve H.15 release, with quotation convention verified |
| `R_FC` | 2.62% | Annual rate, ACT/360 | Placeholder; document the chosen EUR rate and source, e.g. 6-month EURIBOR fixing from EMMI, with quotation convention verified |
| `T_DAYS` | 182 | Days | Case settlement horizon |
| `K_PUT` | 1.1609 | USD per EUR | At-spot strike convention; initially equal to `S0_in` |
| `PREM_PUT` | 0.0194 | USD per EUR | Case placeholder; verify premium quotation |
| `K_CALL` | 1.1609 | USD per EUR | At-spot strike convention; initially equal to `S0_in` |
| `PREM_CALL` | 0.0296 | USD per EUR | Case placeholder; verify premium quotation |

**Placeholder clarification:** The 4.28% USD and 2.62% EUR rates are selected indicative placeholders, not rates verified as provided by the case. The current `S0_in` value of 1.1609 is also an indicative placeholder, not a verified market close. It was selected to be approximately consistent with the supplied forward and rates under covered interest-rate parity. Record its basis and explain its difference from the 1.118 reference in the Stage 1 brief when the source brief is checked. Do not describe these values as observed market quotes until Stage 4 sourcing is complete.

Both interest rates use ACT/360. All exchange rates and option premiums are quoted in USD per EUR.

### 2.1 Derived / Intermediate Values

| Name | Description | Formula |
|---|---|---|
| `DF_USD` | USD accumulation factor | `1 + R_USD × T_DAYS / 360` |
| `DF_FC` | EUR accumulation factor | `1 + R_FC × T_DAYS / 360` |
| `S_T_grid` | Ending-spot sensitivity grid | `S0_in × (1 + shift)`, shifts -5% to +5% by 1% |
| `USD_NO_HEDGE` | Unhedged USD proceeds | `FC_AMT × S_T` |
| `USD_FWD` | Forward proceeds | `FC_AMT × F0_in` |
| `USD_MM` | Money-market proceeds | `(FC_AMT / DF_FC) × S0_in × DF_USD` |
| `USD_PUT` | Net put proceeds | `FC_AMT × MAX(S_T, K_PUT) − FC_AMT × PREM_PUT` |
| `PUT_FLOOR` | Minimum net put proceeds | `FC_AMT × K_PUT − FC_AMT × PREM_PUT` |
| `CALL_NET` | Standalone EUR call net payoff | `FC_AMT × MAX(S_T − K_CALL, 0) − FC_AMT × PREM_CALL` |

Use these standardized names consistently. The ten core inputs in §2 are the required adjustable inputs.

## 3. Tab Architecture

The workbook must contain at least these tabs:

| Tab | Purpose |
|---|---|
| `Cover` | Scenario, exposure, purpose, author/date, data provenance, headline results |
| `Legend_Key` | Workbook color convention |
| `Inputs` | Ten named inputs, values, units, placeholder/source notes |
| `Forward_Hedge` | Forward proceeds |
| `Money_Market_Hedge` | Three separate steps: borrow EUR, convert to USD, invest USD |
| `Option_Hedge` | Put proceeds/floor and call payoff for payable variant |
| `Sensitivity` | Eleven scenarios, all receivable strategies, formula-driven winner, chart |
| `Notes_Assumptions` | Assumptions, limitations, market-data sources, access dates, timestamps, validation results |

### 3.1 Presentation and color convention

Use the Stage 3 build contract convention consistently throughout the workbook:

- **Yellow:** user inputs
- **Blue:** assumptions / placeholders
- **Green:** formulas
- **Gray:** outputs

Keep the workbook readable, auditable, and consistent. Formula cells must not contain pasted results.

## 4. Assumptions & Constraints

1. Exposure: EUR 6,300,000 receivable, settlement in 182 days.
2. Quote convention: USD per EUR; higher `S_T` means the euro has appreciated.
3. Day-count: `R_USD` and `R_FC` are annual rates using ACT/360; accumulation formulas divide by 360.
4. Transaction costs, bank fees, bid-ask spreads, and taxes are excluded; document these as limitations.
5. Option premium is paid upfront in USD. Deduct `FC_AMT × PREM_PUT` from put proceeds as directed; do not future-value the premium.
6. `K_PUT` and `K_CALL` initially equal `S0_in`.
7. Money-market and forward proceeds should approximately converge under covered interest-rate parity. The validation tolerance is 0.05% of forward proceeds.
8. Sensitivity uses deterministic ending-spot scenarios, not probabilities or implied volatility.
9. The main comparison is for a EUR receivable. A EUR call is included for the payable variant, not as a fourth receivable hedge.
10. Winner labels are formula-driven. If forward and money-market proceeds are within 0.05% of forward proceeds, label them “Forward / MM” unless another strategy exceeds their proceeds by more than the same tolerance. Otherwise label the strategy with the highest proceeds.

## 5. Calculation Flow

Use standardized names and named-range references. Do not hard-code calculated values.

### Step 1 — Derived inputs

- `DF_USD = 1 + R_USD × T_DAYS / 360`
- `DF_FC = 1 + R_FC × T_DAYS / 360`

### Step 2 — Forward hedge

Sell the EUR receivable forward:

`USD_FWD = FC_AMT × F0_in`

Using the current placeholders, expected forward proceeds are **$7,374,150**.

### Step 3 — Money-market hedge (three separate steps)

1. **Borrow EUR:** `Borrowed_EUR = FC_AMT / (1 + R_FC × T_DAYS / 360)`
2. **Convert to USD:** `USD_Today = Borrowed_EUR × S0_in`
3. **Invest USD:** `USD_MM = USD_Today × (1 + R_USD × T_DAYS / 360)`

Using current placeholders, expected values are approximately €6,217,644 borrowed, $7,218,063 converted today, and $7,374,246 at settlement. Display precision may cause small differences.

### Step 4 — Interest-rate-parity check

`Implied_Forward = S0_in × (1 + R_USD × T_DAYS / 360) / (1 + R_FC × T_DAYS / 360)`

Show the implied forward, quoted forward, USD proceeds difference, and percentage difference. The check passes when the money-market and forward proceeds differ by no more than 0.05% of forward proceeds.

### Step 5 — Put option hedge

For each ending spot `S_T`:

`USD_PUT = FC_AMT × MAX(S_T, K_PUT) − FC_AMT × PREM_PUT`

Put floor:

`PUT_FLOOR = FC_AMT × K_PUT − FC_AMT × PREM_PUT`

Below the strike, the put protects the conversion rate. Above the strike, the company participates in euro appreciation, less premium.

### Step 6 — Call option payoff

For the payable variant, calculate:

`CALL_NET = FC_AMT × MAX(S_T − K_CALL, 0) − FC_AMT × PREM_CALL`

The call payoff must be a function of `S_T`. It is not part of the main receivable strategy ranking.

### Step 7 — Sensitivity table

For each `S_T` in the grid, calculate:

| Strategy | Formula |
|---|---|
| Unhedged | `USD_NO_HEDGE = FC_AMT × S_T` |
| Forward | `USD_FWD = FC_AMT × F0_in` |
| Money market | `USD_MM = (FC_AMT / DF_FC) × S0_in × DF_USD` |
| Put | `USD_PUT = FC_AMT × MAX(S_T, K_PUT) − FC_AMT × PREM_PUT` |
| Call payoff (payable variant) | `CALL_NET = FC_AMT × MAX(S_T − K_CALL, 0) − FC_AMT × PREM_CALL` |
| Best strategy | Formula-driven comparison using the documented tolerance |

## 6. Sensitivity Plan

`S_T` runs from 0.95 × `S0_in` to 1.05 × `S0_in` in 1% increments, exactly eleven scenarios: -5%, -4%, -3%, -2%, -1%, 0%, +1%, +2%, +3%, +4%, and +5%.

Compare unhedged conversion, forward, money-market, and put proceeds in the main sensitivity table. Include the call payoff as a separate payable-variant output. The chart shows the four receivable strategies, with `S_T` on the horizontal axis and USD proceeds on the vertical axis.

The formula-driven comparison should show the Forward/MM tie label within the specified 0.05% tolerance around parity and unhedged conversion as the winner when its proceeds exceed the hedged proceeds beyond the tolerance. Do not hard-code scenario winner labels.

## 7. Validation Rules

The workbook must visibly compute the following checks. Do not mark any check complete until recalculated and inspected.

- All ten required names exist and point to the intended input cells.
- Both rates use ACT/360 and calculation formulas divide by 360.
- Forward proceeds equal `FC_AMT × F0_in`; expected base-case value is $7,374,150.
- `Borrowed_EUR × (1 + R_FC × T_DAYS / 360)` equals `FC_AMT`, subject to rounding.
- Money-market proceeds are approximately $7,374,246 with current placeholders.
- Forward/MM proceeds agree within 0.05%; show absolute and percentage difference.
- Put payoff and floor formulas correctly deduct the premium.
- Sensitivity contains exactly eleven formula-driven scenarios from 0.95 × `S0_in` to 1.05 × `S0_in`, at 1% increments.
- Every calculated output is formula-driven.
- No Excel formula errors such as `#DIV/0!`, `#VALUE!`, `#REF!`, or `#NAME?`.
- Changing an input updates dependent calculations, table, winner labels, and chart.
- Workbook colors follow §3.1.

## 8. Outputs

| Output | Description |
|---|---|
| `USD_FWD` | Forward proceeds |
| `Borrowed_EUR` | EUR borrowed at inception |
| `USD_Today` | USD converted at spot |
| `USD_MM` | Money-market proceeds at settlement |
| `Implied_Forward` | Covered-interest-parity implied rate |
| `PUT_FLOOR` | Minimum net put proceeds |
| `USD_NO_HEDGE` | Unhedged proceeds by `S_T` |
| `USD_PUT` | Net put proceeds by `S_T` |
| `CALL_NET` | Call payoff for payable variant by `S_T` |
| `Sensitivity_Table` | Eleven scenarios and formula-driven winner |
| `Sensitivity_Chart` | Line chart comparing the four receivable strategies |

### 8.1 Base-case reference values

At `S_T = S0_in`, current placeholder values imply approximately:

| Strategy | USD proceeds |
|---|---:|
| No hedge | $7,313,670 |
| Forward | $7,374,150 |
| Money market | $7,374,246 |
| Put | $7,191,450 |

The money-market/forward difference is approximately $96 and is within the 0.05% tolerance. These are regression reference values, not substitutes for formula-driven workbook outputs.

## 9. Stage Connection

This specification is the Stage 3 workbook build contract. Stage 4 replaces placeholder market data with researched sources and records source, access date, and quotation timestamp. Stage 5 validates the final model and supports the CFO decision memo.

## Appendix A — Change Log

| Version | Date | Author | Change |
|---|---|---|---|
| 0.1 | 2026-11-06 | Nicholas Bonilla | Initial draft |
| 1.0 | 2026-11-06 | Nicholas Bonilla | Formatting revision |
| 1.1 | 2026-11-20 | AI-assisted review; student verification required | Clarified placeholders, removed unsupported market-data claims, documented Stage 4 source plan, corrected tolerance/winner logic, removed screenshot and drafting commentary, aligned workbook color convention |

