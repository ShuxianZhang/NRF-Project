clear all

cd D:\Stata

use panel.dta

set matsize 11000

gen ryear = year - announce

gen rryear = ryear + 15

xtset id rryear

gen subject=0 
replace subject=1 if discipline=="chemistry"
replace subject=2 if discipline=="physics"
replace subject=3 if discipline=="materials science"
replace subject=4 if discipline=="engineering"
replace subject=5 if discipline=="computer science"
replace subject=6 if discipline=="geoscience"

egen yrsb=group(apply subject), label

drop if complete==0

drop if withdrew == "Y"

gen male=1 if gender=="male"

gen yrsincephd=year-phd

gen nrf=0
replace nrf=1 if award=="NRF" & accept=="Yes"


gen logpb=log(pb+1)
gen logct=log(avgct+1)
gen loghi=log(hi+1)

gen logavgct_xs=log(avgctxs+1)
gen loghi_xs=log(hixs+1)

gen logavgct_xa=log(avgctxa+1)
gen loghi_xa=log(hixa+1)

/*
gen logipb=log(ipb+1)
gen logiipb=log(iipb+1)

gen logict=log(ict+1)
gen logiict=log(iict+1)

gen pipb=ipb/(pb+1)
gen piipb=iipb/(pb+1)
*/

fvset base 15 rryear

//04-12
est clear
quietly{
eststo pb_1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=18 & announce<=2012, cl(id)
outreg2 using result.xls,replace dec(3) adjr2

eststo pb_2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=19 & announce<=2011, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo pb_3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=20 & announce<=2010, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo pb_4:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=21 & announce<=2009, cl(id)
outreg2 using result.xls,append dec(3) adjr2
}
esttab pb*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
//all
eststo hi_1:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=18 & announce<=2012, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_2:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=19 & announce<=2011, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_3:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=20 & announce<=2010, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_4:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=21 & announce<=2009, cl(id)
outreg2 using result.xls,append dec(3) adjr2

//xs
eststo hi_xs_1:reg loghi_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=18 & announce<=2012, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_xs_2:reg loghi_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=19 & announce<=2011, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_xs_3:reg loghi_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=20 & announce<=2010, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_xs_4:reg loghi_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=21 & announce<=2009, cl(id)
outreg2 using result.xls,append dec(3) adjr2

//xa
eststo hi_xa_1:reg loghi_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=18 & announce<=2012, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_xa_2:reg loghi_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=19 & announce<=2011, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_xa_3:reg loghi_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=20 & announce<=2010, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo hi_xa_4:reg loghi_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=21 & announce<=2009, cl(id)
outreg2 using result.xls,append dec(3) adjr2
}
esttab hi*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


est clear
quietly{
//all
eststo avgct_1:reg logavgct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=18 & announce<=2012, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_2:reg logavgct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=19 & announce<=2011, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_3:reg logavgct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=20 & announce<=2010, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_4:reg logavgct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=21 & announce<=2009, cl(id)
outreg2 using result.xls,append dec(3) adjr2

//xs
eststo avgct_xs_1:reg logavgct_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=18 & announce<=2012, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_xs_2:reg logavgct_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=19 & announce<=2011, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_xs_3:reg logavgct_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=20 & announce<=2010, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_xs_4:reg logavgct_xs i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=21 & announce<=2009, cl(id)
outreg2 using result.xls,append dec(3) adjr2

//xa
eststo avgct_xa_1:reg logavgct_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=18 & announce<=2012, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_xa_2:reg logavgct_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=19 & announce<=2011, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_xa_3:reg logavgct_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=20 & announce<=2010, cl(id)
outreg2 using result.xls,append dec(3) adjr2

eststo avgct_xa_4:reg logavgct_xa i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=14 & rryear<=21 & announce<=2009, cl(id)
outreg2 using result.xls,append dec(3) adjr2
}
esttab ct*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps




