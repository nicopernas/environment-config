# Gastos Trimestrales - Quarterly Expense Processing

Process a quarter's expense folder: classify PDFs, rename files, and generate a summary spreadsheet.

## Context

You are processing expenses for a Spanish autónomo (freelancer). The folder structure is:
- `facturas/gastos-YYYY-TQ/` — contains PDFs for that quarter (invoices + bank receipts)
- `facturas/Cuentas YYYY TQ.xlsx` — quarterly summary spreadsheet
- A `.heic`, `.png`, or `.jpg` screenshot of income (Revolut transfers from Pro → Personal)

The user's personal details (name, NIF, address) and client info can be found in the invoices themselves and
in the previous quarter's spreadsheet. Do not hardcode them — extract from the documents.

## Step 1: Identify the quarter

Determine the target quarter from the working directory name (e.g., `gastos-2026-T1` → Q1 2026).
Find the previous quarter's spreadsheet in `facturas/` to get the format and the last invoice number used.

## Step 2: Read and classify all PDFs

Read every PDF in the folder. Classify each as:

**INVOICE** — a document from a vendor billing the user. Look for:
- "Factura", "Invoice", "Statement of Fees"
- Documents from TGSS (Seguridad Social) with payment amounts
- Insurance receipts ("Justificante de Pago")
- Train tickets, hotel bills, coworking day passes, subscriptions, etc.

**BANK RECEIPT** — a transaction confirmation from the bank. Look for:
- Bank "EUR Statement" or "Transfer Confirmation" documents
- Files with "transaction-statement_*" or "transaction-confirmation-report_*" patterns
- Bank "Adeudo por domiciliación" documents (for direct debits)

## Step 3: Match receipts to invoices

Match each bank receipt to its invoice by cross-referencing:
- Amount (must match exactly)
- Date (receipt date ≈ invoice date)
- Vendor name / reference number
- For Revolut transfer confirmations: the "Reference" field often contains the invoice number

Flag any orphan receipts (no matching invoice) or orphan invoices (no matching receipt).

## Step 4: Rename files

**Invoices** — rename to: `factura-VENDOR-YYYY-MM-DD.pdf`
- Vendor should be lowercase, hyphenated, short but identifiable
- Date is the invoice date
- Examples: `factura-coworkup-valencia-2026-01-23.pdf`, `factura-melia-madrid-2026-02-11.pdf`

**Bank receipts** — rename to: `factura-VENDOR-YYYY-MM-DD-transaccion.pdf`
- Use the SAME name as the matched invoice, with `-transaccion` suffix
- For orphan TGSS monthly direct debits (Openbank adeudo): `tgss-cuota-autonomos-YYYY-MM-transaccion.pdf`

Present the full rename plan to the user BEFORE executing.

## Step 5: Find the income screenshot

Look for `.heic`, `.png`, or `.jpg` files in the folder. Convert `.heic` to `.png` using `sips` if needed.
Read the image to extract Revolut transfer amounts (Pro → Personal). Use the **EUR values** (not USD).
Note: invoice numbers continue sequentially from the previous quarter's last invoice number.

## Step 6: Create the spreadsheet

Create `facturas/Cuentas YYYY TQ.xlsx` using openpyxl (use the venv at `facturas/.venv`, create if missing).

### Gastos sheet

Row 1: empty
Row 2: headers — `Fecha de emisión | Número de Factura | Tipo de operación | Proveedor | NIF | Concepto | Base | IVA | IVA (%) | Total`

Data rows (starting row 3), sorted as:
1. **TGSS entries first** (regularización, then monthly cuotas) — chronological
2. **Accountant** — identified from the previous quarter's spreadsheet
3. **Everything else** — chronological

For each expense:
- `Base` = base imponible (excl. IVA). For items without IVA (TGSS, insurance, foreign services, bank fees), Base = total paid.
- `IVA (%)` = decimal (0.21, 0.10, or 0.0)
- `IVA` = formula `=G{row}*I{row}`
- `Total` = formula `=G{row}+H{row}`
- For accountant invoices (have IRPF retention not modeled in this sheet): Base = total amount paid, IVA% = 0

Common IVA rates:
- 21%: coworking, office supplies, electronics, professional services
- 10%: hotels, transport (trains)
- 0%: TGSS, insurance (exempt), foreign services, bank fees, accountant (simplified)

Total row: SUM formulas for Base, IVA, and Total columns. Bold font.

### Ingresos sheet

Row 1: headers — `Fecha de emisión | Número de Factura | Cliente | NIF | Concepto | Base | IVA | IVA (%) | Total | Cuenta contable de gasto`

Data rows (starting row 2):
- Client: extract from the previous quarter's spreadsheet
- Concepto: `Prestación de servicios`
- Base: EUR amount from screenshot
- IVA%: 0.0 (foreign company, no IVA)
- IVA: formula `=F{row}*H{row}`
- Total: formula `=F{row}+G{row}`

Total row: SUM formulas for Base, IVA, and Total columns. Bold font.

### Formatting

- Dates: `dd/MM/yyyy`
- Currency: `[$€]#,##0.00`
- Percentages: `0.00%`
- Column widths: A=20, B=26.63, C=20.13, D=36.38, E=14.75, F=40.88, G=14, H=14, I=14.88, J=14

## Step 7: Verify and report

Print a summary:
- Number of invoices, receipts, orphans
- Gastos total (Base + IVA = Total)
- Ingresos total
- Any items needing user attention (ambiguous dates, orphan files, etc.)
