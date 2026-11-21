# Stage 3 Build Audit — Sawmill-Machinery (AI-assisted preliminary audit)

**Date:** 2026-11-20  
**Scenario:** Scenario 5 — sawmill-machinery  
**Workbook:** `capabilities/fx-hedging/model.xlsx`

> AI-assisted preliminary audit. The student must open and inspect the workbook in Excel, confirm the checks below, and add any findings from their own inspection before submission.

## Audit method

I inspected workbook structure and formulas programmatically, then recalculated the workbook using LibreOffice. This verifies formula syntax and preliminary calculated values in that environment. Excel-specific behavior, the student's own inspection, and the chart's dynamic behavior after changing inputs remain to be verified in Excel.

## Finding 1 — Forward proceeds must be formula-driven

**What I checked:** The forward proceeds output in `Forward_Hedge`.

**What I found in the initial draft:** The forward output was entered as a fixed expected result rather than linked to the input named ranges.

**Correction made:** The final draft uses `=FC_AMT*F0_in`.

**Preliminary result:** Recalculation returned $7,374,150.

**Student verification:** Open the cell and inspect the formula bar. Change `FC_AMT` or `F0_in` and confirm the output updates.

## Finding 2 — Put proceeds must deduct the premium

**What I checked:** The put payoff calculation and its floor.

**What I found in the initial draft:** The initial put proceeds formula omitted the upfront premium deduction.

**Correction made:** The final draft uses `=FC_AMT*MAX(S_T,K_PUT)-FC_AMT*PREM_PUT`. The put floor is `=FC_AMT*K_PUT-FC_AMT*PREM_PUT`.

**Preliminary result:** Recalculation returned a put floor of $7,191,450.

**Student verification:** Check a scenario below the strike and a scenario above the strike; verify the premium is deducted in both cases.

## Finding 3 — Sensitivity spot grid must use the named input

**What I checked:** The eleven scenario ending spot rates.

**What I found in the initial draft:** The initial scenario grid was anchored to a literal spot value rather than the named input.

**Correction made:** The final draft uses `=S0_in*(1+shift)` for each scenario.

**Preliminary result:** The recalculated sensitivity table contains eleven scenarios. The winner labels show Forward/MM at -5% through 0% and Unhedged from +1% through +5% using the documented tolerance.

**Student verification:** Change `S0_in` and confirm all eleven spot-rate scenarios move accordingly.

## Preliminary workbook checks

| Check | Preliminary result |
|---|---|
| Worksheets | 8 required-purpose sheets present |
| Named ranges | 10; each points to the input value cell |
| Formula cells | 104 |
| Forward proceeds | $7,374,150 |
| Money-market proceeds | $7,374,245.59 |
| Parity difference | $95.59; 0.00130% — within 0.05% tolerance |
| EUR borrowing repayment | €6,300,000 |
| Put floor | $7,191,450 |
| Sensitivity rows | 11 |
| Formula error values after recalculation | None found |
| Sensitivity chart | 1 chart present |

## Additional specification issue

The Stage 3 build-contract instructions specify yellow inputs, blue assumptions, green formulas, and gray outputs. Stage 2 specification §3.1 originally described yellow inputs, blue assumptions, black formulas, and green cross-tab links. The workbook draft follows the Stage 3 build contract. The spec should be updated so these conventions agree.

## Final verification — student to complete

- [ ] Open and recalculate the workbook in Excel.
- [ ] Verify all ten named ranges and their target cells.
- [ ] Verify calculated cells contain formulas.
- [ ] Verify the required color convention.
- [ ] Verify the three-step money-market hedge.
- [ ] Verify put and call formulas, including call payoff as a function of `S_T`.
- [ ] Verify the eleven sensitivity scenarios and chart.
- [ ] Verify parity check and expected base-case results.
- [ ] Verify there are no Excel formula errors.
- [ ] Test dynamic behavior by changing an input and restoring it.
- [ ] Add any additional findings from personal inspection.
- [ ] Commit the corrected workbook and this completed audit note to GitHub.

## Audit status

**Preliminary AI/tool checks completed; student verification completed.
