# FX Hedging Project — AI Prompt Log

**Project:** FX Transaction Hedging  
**Scenario:** 5 — Sawmill-Machinery  
**Author:** Nicholas Bonilla  
**Date:** November 6, 2026

## Iteration 1 — AI Review of Stage 2 Model Specification

**Purpose:** Review the initial Stage 2 specification against the assignment requirements, identify weaknesses, and improve the document before beginning the Stage 3 workbook build.

**AI Tool:** Claude (Sonnet 5.5)

### Prompt Used

I asked Claude to review my Stage 2 FX Transaction Hedging specification for Scenario 5 (sawmill-machinery).

The review was requested to:
- Compare the specification against the Stage 2 assignment requirements.
- Check all ten required named inputs, placeholder values, units, and Stage 4 data sources.
- Verify the forward hedge, money-market hedge, and option calculations.
- Review the sensitivity analysis and validation rules.
- Identify incorrect assumptions, unsupported claims, and inconsistencies.
- Identify specific weaknesses and explain how to correct them.

I asked the AI to review the document critically rather than simply approve it or rewrite the entire specification.

### AI Review Findings

The review found that the specification met several important requirements:

- Included the required template information and problem statement.
- Included all ten named inputs with values, units, and ACT/360 conventions.
- Clearly identified placeholder values.
- Defined the required workbook tabs and their purposes.
- Specified the calculation flow using named ranges rather than cell addresses.
- Included the three separate money-market hedge steps.
- Specified eleven sensitivity scenarios from -5% to +5% in 1% increments.
- Included validation rules, parity checks, and expected base-case results.

However, the review identified seven issues that needed correction before Stage 3.

### Issues Identified and Revisions Required

**1. Unsupported claim about the interest-rate inputs**

- **Problem:** Section 2 stated that the assignment provided the USD interest rate of 4.28% and EUR interest rate of 2.62%.
- **AI feedback:** These rates were selected as placeholders and were not explicitly provided by the case assignment.
- **Revision:** Clarify that 4.28% and 2.62% are chosen indicative placeholder rates rather than case-provided values. Explain their intended Stage 4 replacement with sourced market rates.

**2. Incorrect description of the Stage 2 market-data requirement**

- **Problem:** The specification claimed that the assignment required spot and interest rates to be sourced from the market close on the date Stage 2 began.
- **AI feedback:** The assignment instructions do not establish that requirement.
- **Revision:** Remove the unsupported claim and explain that the current values are placeholders that will be replaced with researched market data during Stage 4.

**3. Incorrect description of the initial spot rate**

- **Problem:** S0_in = 1.1609 was described as a market-close quotation.
- **AI feedback:** The value is a back-solved placeholder used to make the supplied forward rate and interest rates approximately satisfy covered interest rate parity. It should not be represented as a verified live market quote.
- **Revision:** Clearly identify 1.1609 as an indicative placeholder and explain its relationship to the parity calculation. Also document why it differs from the 1.118 used in the Stage 1 brief.

**4. Inconsistency in the sensitivity winner calculation**

- **Problem:** The specification stated that the forward hedge wins from -5% through 0%, but the money-market hedge produces $7,374,246 compared with forward proceeds of $7,374,150.
- **AI feedback:** The difference is $96, so the money-market hedge technically produces more under the raw maximum formula. The specification needs a consistent tie or tolerance rule.
- **Revision:** Define a 0.05% tolerance for comparing the forward and money-market results. When their difference falls within this tolerance, display the winner as "Forward / MM" rather than incorrectly treating the small difference as a meaningful advantage.

**5. Unsupported screenshot reference**

- **Problem:** Section 6 referred to a supplied scenario screenshot as the basis for the expected winners.
- **AI feedback:** A specification should communicate expected results independently of a screenshot.
- **Revision:** Remove the screenshot reference and state the expected sensitivity results directly, with the winner labels determined by formulas and the documented tolerance rule.

**6. Unnecessary template and drafting instructions**

- **Problem:** Section 9, "Writing a Strong Specification," included instructions about professional writing, drafting, and document length rather than actual model requirements.
- **AI feedback:** These instructions belong to the writing process, not the technical handoff specification.
- **Revision:** Remove unnecessary drafting commentary and retain only information relevant to building, auditing, and understanding the FX hedging model.

**7. Insufficiently specific Stage 4 data sources**

- **Problem:** The specification used general descriptions such as "Find USD interest rate" and "Find EUR interest rate."
- **AI feedback:** These descriptions do not identify the actual instruments or data sources needed to replace the placeholders.
- **Revision:** Specify the intended source types and instruments for the USD and EUR interest rates, including the relevant maturity and source publication. Document the actual source, access date, and quotation timestamp when Stage 4 research is completed.

### Reflection

This review showed me that a specification can contain the correct formulas and calculations while still having problems with its assumptions, source descriptions, and consistency.

The most important finding was the difference between the forward and money-market hedge proceeds. Although the two strategies should approximately converge under covered interest rate parity, the $96 difference meant that the winner calculation needed a clearly documented tolerance rule.

I also learned that placeholder values must be distinguished from verified market data. This is important because the Stage 3 workbook will be built using the specification, while Stage 4 will replace the placeholders with researched market inputs.

### Revision Status

- [x] Initial specification reviewed by AI.
- [x] Specific weaknesses identified and documented.
- [ ] Unsupported claims about case-provided rates corrected.
- [ ] Spot-rate placeholder explanation corrected.
- [ ] Sensitivity winner and tolerance logic corrected.
- [ ] Screenshot reference removed.
- [ ] Drafting commentary removed.
- [ ] Stage 4 data sources clarified.
- [ ] Final specification checked against assignment requirements.

**Next step:** Complete the revisions in `spec.md` before beginning the Stage 3 workbook build.

## Stage 3 — AI-assisted workbook build

**AI tool:** Claude (Sonnet 5.5)  
**Date:** 2026-11-20

### Build prompt

I provided the Stage 2 specification and requested an Excel workbook named `model.xlsx` containing the ten named inputs, formula-driven calculations, cover and legend tabs, forward and three-step money-market hedges, put/call option calculations as functions of ending spot, an eleven-scenario sensitivity table and chart, and visible validation checks. I instructed the AI to flag ambiguities and produce an actual `.xlsx` workbook.

### Build record

The workbook was generated as an AI-assisted draft. It follows the Stage 3 build-contract color convention: yellow inputs, blue assumptions, green formulas, and gray outputs. The Stage 2 specification had a conflicting color description; the revised spec draft reconciles this.

### Draft inspection and corrections

Three defects were identified in the initial workbook draft and corrected before saving the current `model.xlsx`:

1. **Forward proceeds formula:** The draft used a fixed expected result. It was changed to `=FC_AMT*F0_in`.
2. **Put proceeds:** The draft omitted the upfront premium deduction. It was changed to `=FC_AMT*MAX(S_T,K_PUT)-FC_AMT*PREM_PUT`.
3. **Sensitivity spot grid:** The draft used a literal spot rate. It was changed to use the named input, `=S0_in*(1+shift)`.

### Preliminary automated recalculation

The workbook was recalculated with LibreOffice for a preliminary formula check. The checks returned: forward proceeds $7,374,150; money-market proceeds approximately $7,374,245.59; put floor $7,191,450; parity difference approximately $95.59 (about 0.00130%); EUR borrowing repayment equals €6,300,000; and eleven sensitivity rows. The workbook contained ten named input ranges and no formula-error values in the recalculated file.

## Stage 4 market-data retrieval and population (2026-11-20)

- Retrieved the ECB EUR/USD reference rate for 2026-11-20 (1.0990) and selected 1-year government-yield proxies for USD (U.S. Treasury, 4.51%) and EUR (Germany, 2.995%).
- Recorded source URLs and dates in the market-data memo and workbook Inputs tab.
- Kept scenario forward (1.1705) and option premiums (put 0.0194; call 0.0296) as scenario assumptions; they were not independently verified as live quotes.
- Computed CIP-implied forward with ACT/360 and 182 days. The gap is material; did not alter inputs to force parity.
- Workbook sensitivity/ chart and formula recalculation require verification in Excel.
- FX Hedging Lab cross-check is complete; everything is in order.

