Package documentation adapted for stats.camp.

Aging, Output Per Capita, and Secular Stagnation
Gauti B. Eggertsson, Manuel Lancastre, and Lawrence H. Summers

Replication

1. Keep AGING_GROWTH.dta and the .do files together in Data_and_do_files/.
2. Open an individual .do file in stats.camp. Each script is an independent
   entry point. For a local working copy, set its cd and global maindir paths
   to the folder containing the data. The deposited scripts retain their
   original absolute Windows paths; use scratch copies for path changes and
   execution so that reference outputs remain intact.
3. Run the selected .do file.

Dataset: AGING_GROWTH.dta

The authors combine GDP and capital stock data from Penn World Table for
169 countries with aging data from the United Nations, estimates of real
interest rates from the World Bank, and risk-free nominal interest rates
from the IMF International Financial Statistics Database (IFS).

For each country, when available, the closest proxy for the monetary policy
interest rate is used to construct min_i_08_14: the minimum value during
2008-2014. IFS variables are considered in this order:
1. Monetary policy-related interest rate
2. Treasury Bill Rate
3. Discount Rate
4. Money Market Rate
5. Deposit Rate
6. Lending Rate

See Monetary_Policy_IR_MIN_08_14.pdf for details. The three countries without
available IFS data are assumed not to have been at the zero lower bound
between 2008 and 2014.

Scripts (actual filenames in this package)

Figure:
  Figure_1.do

Manuscript tables:
  Table_1_Panel_A.do
  Table_1_Panel_B.do
  Table_2_Panel_A.do
  Table_2_Panel_B.do
  Table_2_Panel_C.do

Appendix tables:
  APPENDIX_Table_A1.do
  APPENDIX_Table_A2_Panel_A.do
  APPENDIX_Table_A2_Panel_B.do
  APPENDIX_Table_A2_Panel_C.do
  APPENDIX_Table_A3.do
  APPENDIX_Table_A4_Panel_A.do
  APPENDIX_Table_A4_Panel_B.do
  APPENDIX_Table_A4_Panel_C.do
  APPENDIX_Table_A5.do
  APPENDIX_Table_A6_Panel_A.do
  APPENDIX_Table_A6_Panel_B.do
  APPENDIX_Table_A6_Panel_C.do
  APPENDIX_Table_A7_Panel_A.do
  APPENDIX_Table_A7_Panel_B.do
  APPENDIX_Table_A8.do
  APPENDIX_Table_A9_Panel_A.do
  APPENDIX_Table_A9_Panel_B.do
  APPENDIX_Table_A9_Panel_C.do

Adapted from the authors' ReadMe.pdf in official AEA deposit 231432, V1.
The original PDF is preserved in the maintainer's external preparation archive.
