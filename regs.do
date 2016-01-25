clear all

use inrfpanel

set matsize 11000

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

drop if announce==2014

drop if year==2015

gen male=gender=="male"

gen yrsincephd=year-phd_grad

gen loghi=log(hi+1)
gen logpb=log(pb+1)
gen logct=log(ct+1)

gen logipb=log(ipb+1)
gen logiipb=log(iipb+1)

gen logict=log(ict+1)
gen logiict=log(iict+1)

gen pipb=ipb/(pb+1)
gen piipb=iipb/(pb+1)


fvset base 13 rryear

/*
//12-23

est clear
forvalues i=0/1{
quietly{
eststo pb08_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)
eststo ipb08_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)
eststo iipb08_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)

eststo pb09_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)
eststo ipb09_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)
eststo iipb09_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)

eststo pb10_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)
eststo ipb10_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)
eststo iipb10_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)

eststo pb11_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
eststo ipb11_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
eststo iipb11_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
}
}
esttab pb08*0 ipb08*0 iipb08*0 pb09*0 ipb09*0 iipb09*0, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb10*0 ipb10*0 iipb10*0 pb11*0 ipb11*0 iipb11*0, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab pb08*1 ipb08*1 iipb08*1 pb09*1 ipb09*1 iipb09*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb10*1 ipb10*1 iipb10*1 pb11*1 ipb11*1 iipb11*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo pb08_ols_21:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)
eststo ipb08_ols_22:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)
eststo iipb08_ols_23:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)

eststo pb08_ols_41:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)
eststo ipb08_ols_42:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)
eststo iipb08_ols_43:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)

eststo pb09_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)
eststo ipb09_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)
eststo iipb09_ols_log3:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)

eststo pb10_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)
eststo ipb10_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)
eststo iipb10_ols_log3:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)

eststo pb11_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
eststo ipb11_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
eststo iipb11_ols_log3:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
}
}
esttab pb08*21 ipb08*22 iipb08*23 pb08*41 ipb08*42 iipb08*43 , drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb09* ipb09* iipb09* pb10* ipb10* iipb10*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb11* ipb11* iipb11*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//add yrsincephd
est clear
forvalues i=0/1{
quietly{
eststo pb08_ols_log`i':reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)
eststo ipb08_ols_log`i':reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)
eststo iipb08_ols_log`i':reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)

eststo pb09_ols_log`i':reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)
eststo ipb09_ols_log`i':reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)
eststo iipb09_ols_log`i':reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)

eststo pb10_ols_log`i':reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)
eststo ipb10_ols_log`i':reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)
eststo iipb10_ols_log`i':reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)

eststo pb11_ols_log`i':reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
eststo ipb11_ols_log`i':reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
eststo iipb11_ols_log`i':reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
}
}
esttab pb08*0 ipb08*0 iipb08*0 pb09*0 ipb09*0 iipb09*0, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb10*0 ipb10*0 iipb10*0 pb11*0 ipb11*0 iipb11*0, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab pb08*1 ipb08*1 iipb08*1 pb09*1 ipb09*1 iipb09*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb10*1 ipb10*1 iipb10*1 pb11*1 ipb11*1 iipb11*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


est clear
quietly{
eststo pb08_ols_21:reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)
eststo ipb08_ols_22:reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)
eststo iipb08_ols_23:reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)

eststo pb08_ols_41:reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)
eststo ipb08_ols_42:reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)
eststo iipb08_ols_43:reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)

eststo pb09_ols_log1:reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)
eststo ipb09_ols_log2:reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)
eststo iipb09_ols_log3:reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)

eststo pb10_ols_log1:reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)
eststo ipb10_ols_log2:reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)
eststo iipb10_ols_log3:reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)

eststo pb11_ols_log1:reg logpb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
eststo ipb11_ols_log2:reg logipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
eststo iipb11_ols_log3:reg logiipb i.nrf##i.rryear yrsincephd if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
}
}
esttab pb08*21 ipb08*22 iipb08*23 pb08*41 ipb08*42 iipb08*43 , drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb09* ipb09* iipb09* pb10* ipb10* iipb10*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb11* ipb11* iipb11*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//controlling for proportion of ipb and iipb # subject
est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#c.pipb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#c.piipb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log4:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log5:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#c.pipb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log6:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#c.piipb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
}
esttab pb_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#c.pipb if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#c.piipb if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
}
esttab pb_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//12-22

//controlling for proportion of ipb and iipb
est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd pipb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd piipb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log4:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log5:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd pipb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log6:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd piipb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
}
esttab pb_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd pipb if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd piipb if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
}
esttab pb_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//1,2 non sig.
est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log4:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd pipb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log5:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd piipb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab pb_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//raw

est clear
quietly{
forvalues i=0/1{
eststo pb08_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)
eststo ipb08_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)
eststo iipb08_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==`i' , cl(id)

eststo pb09_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)
eststo ipb09_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)
eststo iipb09_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==`i' , cl(id)

eststo pb10_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)
eststo ipb10_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)
eststo iipb10_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==`i' , cl(id)

eststo pb11_ols_log`i':reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
eststo ipb11_ols_log`i':reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
eststo iipb11_ols_log`i':reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==`i' , cl(id)
}
}
esttab pb08*0 ipb08*0 iipb08*0 pb09*0 ipb09*0 iipb09*0, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb10*0 ipb10*0 iipb10*0 pb11*0 ipb11*0 iipb11*0, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab pb08*1 ipb08*1 iipb08*1 pb09*1 ipb09*1 iipb09*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb10*1 ipb10*1 iipb10*1 pb11*1 ipb11*1 iipb11*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo pb08_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)
eststo ipb08_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)
eststo iipb08_ols_log3:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==2 , cl(id)

eststo pb08_ols_41:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)
eststo ipb08_ols_42:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)
eststo iipb08_ols_43:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2008 & subject==4 , cl(id)

eststo pb09_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)
eststo ipb09_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)
eststo iipb09_ols_log3:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce==2009 & subject==3 , cl(id)

eststo pb10_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)
eststo ipb10_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)
eststo iipb10_ols_log3:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce==2010 & subject==3 , cl(id)

eststo pb11_ols_log1:reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
eststo ipb11_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
eststo iipb11_ols_log3:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce==2011 & subject==3 , cl(id)
}

esttab pb08*1 ipb08*1 iipb08*1 pb09*1 ipb09*1 iipb09*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
esttab pb10*1 ipb10*1 iipb10*1 pb11*1 ipb11*1 iipb11*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps



//pb, ipb, by subject, 08-09
//life, material worsen for ipb; but in raw graphs, all subjects parallel
est clear
quietly{
forvalues i=0/1{
eststo pb_ols_log`i':reg logpb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009 & subject==`i' , cl(id)
eststo ipb_ols_log`i':reg logipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009 & subject==`i' , cl(id)
}
}
esttab pb*0 ipb*0 pb*1 ipb*1, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps
*/

//01-20
//Alternative specifications
est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols1.xls,replace dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ipb_ols_log1:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ipb_ols_log2:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iipb_ols_log2:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ipb_ols_log3:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iipb_ols_log3:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)
}


est clear
quietly{
eststo ct_ols_log1:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using olsct1.xls,replace dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ict_ols_log1:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iict_ols_log1:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ct_ols_log2:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ict_ols_log2:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iict_ols_log2:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ct_ols_log3:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ict_ols_log3:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iict_ols_log3:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using olsct1.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)
}

////////////////////////////Comparing PB, IPB, IIPB, CT, ICT, IICT
//pb, ipb, OLS, sig. differs
est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols.xls,replace dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ipb_ols_log1:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ipb_ols_log2:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iipb_ols_log2:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ipb_ols_log3:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iipb_ols_log3:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)
}
esttab pb*1 ipb*1 pb*2 ipb*2 pb*3 ipb*3, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps



est clear

eststo ct_ols_log1:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using olsct.xls,replace dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ict_ols_log1:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iict_ols_log1:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ct_ols_log2:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ict_ols_log2:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iict_ols_log2:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ct_ols_log3:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo ict_ols_log3:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)

eststo iict_ols_log3:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
outreg2 using olsct.xls,append dec(3) adjr2 drop(*.yrsb *.subject*)


//pb, ipb, FE, sig. differs
est clear
quietly{
eststo pb_fe_log1:xtreg logpb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo ipb_fe_log1:xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo pb_fe_log2:xtreg logpb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo ipb_fe_log2:xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo pb_fe_log3:xtreg logpb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
eststo ipb_fe_log3:xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
}
esttab pb*1 ipb*1 pb*2 ipb*2 pb*3 ipb*3, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//ct, ict, same sig.
est clear
quietly{
eststo ct_ols_log1:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log1:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_log2:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log2:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_log3:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo ict_ols_log3:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ct*1 ict*1 ct*2 ict*2 ct*3 ict*3, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//ipb,iipb, same sig.

est clear
quietly{
eststo ipb_ols_log1:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_ols_log2:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log2:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iipb_ols_log3:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ipb*1 iipb*1 ipb*2 iipb*2 ipb*3 iipb*3, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//ict, iict, same sig.
est clear
quietly{
eststo ict_ols_log1:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iict_ols_log1:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log2:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iict_ols_log2:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log3:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iict_ols_log3:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ict*1 iict*1 ict*2 iict*2 ict*3 iict*3, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//all
est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log1:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_log2:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_log3:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}
esttab pb_* ct_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo hi_ols_log1:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols_log2:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo hi_ols_log3:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

esttab hi_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//i, FE, OLS

//FE,OLS same coef.
est clear
quietly{
eststo ipb_ols_log1:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_fe_log1:xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo ipb_ols_log2:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_fe_log2:xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo ipb_ols_log3:reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo ipb_fe_log3:xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
}
esttab ipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo ipb_ols_log1:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_ols_log2:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3:reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo ict_ols_log1:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log2:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log3:reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ipb_* ict_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//ii
est clear
quietly{
eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iipb_ols_log2:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log3:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iict_ols_log1:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iict_ols_log2:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iict_ols_log3:reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab iipb_* iict_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps





//same coef.
est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_fe_log1:xtreg logpb i.nrf##i.rryear if rryear>=10 & rryear<=17 & announce<=2010, fe cl(id)

}
esttab pb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log4:reg logpb i.nrf##i.rryear yrsincephd if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
}
esttab pb_*, drop(0.nrf* *.yrsb *.subject*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log4:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log5:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log6:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
}
esttab pb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo pb_ols_log1:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log2:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3:reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log1:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_log2:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_log3:reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}
esttab pb_* ct_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo hi_ols_log1:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols_log2:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo hi_ols_log3:reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

esttab hi_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//12-21

//pb,ct, only 1 minor sig.
est clear
quietly{
eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log1: reg logct i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_log2: reg logct i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab pb_* ct_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//ipb, ict, non-sig.
est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo ict_ols_log1: reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log2: reg logict i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log3: reg logict i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ipb_* ict_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//iipb, iict, non-sig.
est clear
quietly{
eststo iipb_ols_log1: reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iipb_ols_log2: reg logiipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log3: reg logiipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iict_ols_log1: reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iict_ols_log2: reg logiict i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iict_ols_log3: reg logiict i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab iipb_* iict_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//trials
est clear
quietly{
eststo pb_ols_log1: reg logpb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.subject i.apply if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log4: reg logpb i.nrf##i.rryear i.subject i.apply i.male if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log5: reg logpb i.nrf##i.rryear i.subject i.apply i.male i.arwu_phd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log6: reg logpb i.nrf##i.rryear i.subject i.apply i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)

}
esttab pb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//non-sig. time trend for 3,5, corr(rryear, yrsincephd)=0.91
est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear i.yrsb yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log4: reg logipb i.nrf##i.rryear i.subject i.apply if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log5: reg logipb i.nrf##i.rryear i.subject i.apply yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)

}
esttab ipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//non-sig. time trend for 3,5
est clear
quietly{
eststo iipb_ols_log1: reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log2: reg logiipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log3: reg logiipb i.nrf##i.rryear i.yrsb yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log4: reg logiipb i.nrf##i.rryear i.subject i.apply if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log5: reg logiipb i.nrf##i.rryear i.subject i.apply yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)

}
esttab iipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//wrong since 3
est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear i.yrsb if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log4: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log5: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log6: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
}
esttab ipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps



//12-15
//independent research


// full set of regressors, OLS, wrong signs for time trend!!!!

est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iipb_ols_log2: reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log3: reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)


}
esttab ipb_* iipb_*, drop(0.nrf* *.yrsb *.subject* *.arwu* *.male) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011& nrf==0, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010& nrf==0, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009& nrf==0, cl(id)
eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011& nrf==0, cl(id)
eststo iipb_ols_log2: reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010& nrf==0, cl(id)
eststo iipb_ols_log3: reg logiipb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009& nrf==0, cl(id)


}
esttab ipb_* iipb_*, drop(0.nrf* *.yrsb *.subject* *.arwu* *.male) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

est clear
quietly{
eststo ict_ols_log1: reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log2: reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log3: reg logict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iict_ols_log1: reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iict_ols_log2: reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iict_ols_log3: reg logiict i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ict_* iict_*, drop(0.nrf* *.yrsb *.subject* *.arwu* *.male) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


// another full set of regressors, OLS, some wrong signs for time trend!

est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iipb_ols_log2: reg logiipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log3: reg logiipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)


}
esttab ipb_* iipb_*, drop(0.nrf* *.subject* *.arwu* *.male) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


est clear
quietly{
eststo ict_ols_log1: reg logict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log2: reg logict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log3: reg logict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iict_ols_log1: reg logiict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iict_ols_log2: reg logiict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iict_ols_log3: reg logiict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ict_* iict_*, drop(0.nrf* *.subject* *.arwu* *.male) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//partial regressors, OLS

est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iipb_ols_log2: reg logiipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log3: reg logiipb i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)


}
esttab ipb_* iipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


est clear
quietly{
eststo ict_ols_log1: reg logict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log2: reg logict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log3: reg logict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iict_ols_log1: reg logiict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iict_ols_log2: reg logiict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iict_ols_log3: reg logiict i.nrf##i.rryear i.subject i.apply yrsincephd i.male i.arwu_phd if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ict_* iict_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


// minimal regressors, OLS, some + pb.
est clear
quietly{
eststo ipb_ols_log1: reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ipb_ols_log2: reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ipb_ols_log3: reg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iipb_ols_log1:reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iipb_ols_log2: reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iipb_ols_log3: reg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ipb_* iipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


est clear
quietly{
eststo ict_ols_log1: reg logict i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo ict_ols_log2: reg logict i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo ict_ols_log3: reg logict i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
eststo iict_ols_log1: reg logiict i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, cl(id)
eststo iict_ols_log2: reg logiict i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, cl(id)
eststo iict_ols_log3: reg logiict i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, cl(id)
}
esttab ict_* iict_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//minimal regressors, FE, some - ct.
est clear
quietly{
eststo ipb_fe_log1: xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo ipb_fe_log2: xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo ipb_fe_log3: xtreg logipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
eststo iipb_fe_log1:xtreg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo iipb_fe_log2: xtreg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo iipb_fe_log3: xtreg logiipb i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)


}
esttab ipb_* iipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


est clear
quietly{
eststo ict_fe_log1: xtreg logict i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo ict_fe_log2: xtreg logict i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo ict_fe_log3: xtreg logict i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
eststo iict_fe_log1: xtreg logiict i.nrf##i.rryear if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo iict_fe_log2: xtreg logiict i.nrf##i.rryear if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo iict_fe_log3: xtreg logiict i.nrf##i.rryear if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)

}
esttab ict_* iict_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

// full set of regressors, FE, wrong signs for time trend!!!

est clear
quietly{
eststo ipb_fe_log1: xtreg logipb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo ipb_fe_log2: xtreg logipb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo ipb_fe_log3: xtreg logipb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
eststo iipb_fe_log1:xtreg logiipb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo iipb_fe_log2: xtreg logiipb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo iipb_fe_log3: xtreg logiipb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
}
esttab ipb_* iipb_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


est clear
quietly{
eststo ict_fe_log1: xtreg logict i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo ict_fe_log2: xtreg logict i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo ict_fe_log3: xtreg logict i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
eststo iict_fe_log1: xtreg logiict i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=16 & announce<=2011, fe cl(id)
eststo iict_fe_log2: xtreg logiict i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)
eststo iict_fe_log3: xtreg logiict i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=12 & rryear<=18 & announce<=2009, fe cl(id)
}

esttab ict_* iict_*, drop(0.nrf*) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps



eststo iipb_fe_log2: xtreg logiipb i.nrf##i.rryear i.subject#i.year if rryear>=12 & rryear<=17 & announce<=2010, fe cl(id)







//11-19

//+ sig. if 3 batches for hi pb ct, - sig. if more bathes
fvset base 13 rryear
eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols.xls,replace dec(3) adjr2 label sortvar (*rryear)

eststo hi_ols_log2: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)

eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)

eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)

eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)

eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)

eststo ct_ols_log1: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)

eststo ct_ols_log2: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)

eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
outreg2 using ols.xls,append dec(3) adjr2 label sortvar (*rryear)




//+ sig. 1.nrf#16.rryear 1.nrf#17.rryear 1.nrf#18.rryear pb-4,5,6
fvset base 13 rryear
eststo hi_re_log1: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
outreg2 using re.xls,replace dec(3) label sortvar (*rryear)

eststo hi_re_log2: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)

eststo hi_re_log3: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)

eststo pb_re_log1: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)

eststo pb_re_log2: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)

eststo pb_re_log3: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)

eststo ct_re_log1: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)

eststo ct_re_log2: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)

eststo ct_re_log3: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
outreg2 using re.xls,append dec(3) label sortvar (*rryear)




fvset base 13 rryear
eststo hi_fe_log1: xtreg loghi i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=16 & announce<=2011, fe cl(id)
outreg2 using fe.xls,replace dec(3) label sortvar (*rryear)

eststo hi_fe_log2: xtreg loghi i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=17 & announce<=2010, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)

eststo hi_fe_log3: xtreg loghi i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)
                                                                                                                                                                                                                                                                                                            
eststo pb_fe_log1: xtreg logpb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=16 & announce<=2011, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)

eststo pb_fe_log2: xtreg logpb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=17 & announce<=2010, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)

eststo pb_fe_log3: xtreg logpb i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)
                                                                                                                                        
eststo ct_fe_log1: xtreg logct i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=16 & announce<=2011, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)

eststo ct_fe_log2: xtreg logct i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=17 & announce<=2010, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)

eststo ct_fe_log3: xtreg logct i.nrf##i.rryear i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id)
outreg2 using fe.xls,append dec(3) label sortvar (*rryear)


//esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps




set more off
fvset base 13 rryear
est clear

quietly{
eststo nrf_1: probit nrf c.pb##i.rryear c.ct##i.rryear i.subject yrsincephd male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=13 & announce<=2011, cl(id)
eststo nrf_2: probit nrf c.pb##i.rryear c.ct##i.rryear i.subject yrsincephd male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=13 & announce<=2010, cl(id)
eststo nrf_3: probit nrf c.pb##i.rryear c.ct##i.rryear i.subject yrsincephd male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=13 & announce<=2009, cl(id)

}
esttab nrf_* , se star(* 0.1 ** 0.05 *** 0.01) nogaps




set more off
fvset base 13 rryear
est clear


//+ sig. 1.nrf#18.rryear pb-6
quietly{
eststo hi_ols_1: reg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_3: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_4: reg hi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo pb_ols_1: reg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_3: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_4: reg pb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo ct_ols_1: reg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_3: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_4: reg ct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//+ sig. 1.nrf#18.rryear pb-6
quietly{
eststo hi_re_1: xtreg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_3: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_4: xtreg hi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
          
eststo pb_re_1: xtreg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_3: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_4: xtreg pb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
     
eststo ct_re_1: xtreg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_3: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_4: xtreg ct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//+ sig. 1.nrf#17.rryear 1.nrf#18.rryear pb-6
quietly{
eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log4: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
              
eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log4: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
            
eststo ct_ols_log1: reg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log4: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//+ sig. 1.nrf#17.rryear 1.nrf#18.rryear pb-6
quietly{
eststo hi_ols_log1: xtreg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_ols_log3: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_ols_log4: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                   
eststo pb_ols_log1: xtreg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_ols_log3: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_ols_log4: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                 
eststo ct_ols_log1: xtreg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_ols_log3: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_ols_log4: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


















/* 11-11 */
//negative sig. for hi, ct post interactions, positive sig. 1.nrf(pb-6)!!!!!
quietly{
eststo hi_ols_1: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols_2: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo hi_ols_3: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo pb_ols_1: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_2: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_3: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo ct_ols_1: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_2: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_3: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}
esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//negative sig. for hi, ct post interactions, positive sig. 1.nrf(pb-6)!!!!!
quietly {
eststo hi_re_1: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo hi_re_2: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo hi_re_3: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
               
eststo pb_re_1: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo pb_re_2: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo pb_re_3: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
               
eststo ct_re_1: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo ct_re_2: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo ct_re_3: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//positive sig. 1.nrf#17.rryear, pb,<=2010
quietly {
eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols_log2: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
                  
eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
                  
eststo ct_ols_log1: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_log2: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//positive sig. 1.nrf#16.rryear 1.nrf#17.rryear, pb,<=2010
quietly {
eststo hi_re_log1: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo hi_re_log2: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo hi_re_log3: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                  
eststo pb_re_log1: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo pb_re_log2: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo pb_re_log3: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                  
eststo ct_re_log1: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo ct_re_log2: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo ct_re_log3: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps



/*

//post interact nonsig. except 1.nrf#14.rryear 1.nrf(pb-6)!!!!! 1.nrf (all ct)
quietly{
eststo hi_ols_1: reg hi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_2: reg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_3: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo pb_ols_1: reg pb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_2: reg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_3: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo ct_ols_1: reg ct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_2: reg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_3: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

//post interact nonsig. except 1.nrf#14.rryear 1.nrf(pb-6)!!!!! 1.nrf (all ct)
quietly{
eststo hi_re_1: xtreg hi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_2: xtreg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_3: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
          
eststo pb_re_1: xtreg pb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_2: xtreg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_3: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
    
eststo ct_re_1: xtreg ct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_2: xtreg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_3: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

//post interact nonsig.
quietly{
eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log2: reg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
             
eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
           
eststo ct_ols_log1: reg logct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log2: reg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

//post interact nonsig.
quietly{
eststo hi_re_log1: xtreg loghi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_log2: xtreg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_log3: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
             
eststo pb_re_log1: xtreg logpb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_log2: xtreg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_log3: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
           
eststo ct_re_log1: xtreg logct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_log2: xtreg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_log3: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

*/








//probit nrf pb i.yrsb i.arwu_phd i.arwu_insapp male yrsincephd if year==apply & announce<=2009, vce(robust)




/*11-06*/
set more off
fvset base 13 rryear
est clear

quietly {
//eststo hi_fe: xtreg hi i.nrf##ib13.rryear if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id) 
eststo hi_ols2009: reg hi i.yrsb i.nrf##i.rryear if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
//eststo ols2011: reg hi i.yrsb i.nrf i.nrf#i.rryear i.rryear if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols2009_2: reg hi i.yrsb i.nrf##i.rryear i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)
//eststo hi_ols2009_3: reg hi i.yrsb i.nrf##i.rryear##i.subject i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)

//eststo pb_fe: xtreg pb i.nrf##ib13.rryear if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id) 
eststo pb_ols2009: reg pb i.yrsb i.nrf##i.rryear if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
//eststo ols2011: reg pb i.yrsb i.nrf i.nrf#i.rryear i.rryear if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols2009_2: reg pb i.yrsb i.nrf##i.rryear i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)
//eststo pb_ols2009_3: reg pb i.yrsb i.nrf##i.rryear##i.subject i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)



//eststo ct_fe: xtreg ct i.nrf##ib13.rryear if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id) 
eststo ct_ols2009: reg ct i.yrsb i.nrf##i.rryear if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
//eststo ols2011: reg ct i.yrsb i.nrf i.nrf#i.rryear i.rryear if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols2009_2: reg ct i.yrsb i.nrf##i.rryear i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)
//eststo ct_ols2009_2: reg ct i.yrsb i.nrf##i.rryear##i.subject i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)

}
esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb *.subject* *.yrs*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

