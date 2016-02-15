clear all

use nrfall

gen male=gender=="male"

gen award=0 if award_status=="Neither"
replace award=1 if award_status=="NAP"
replace award=2 if award_status=="NRF"

gen subject=0 
replace subject=1 if discipline=="chemistry"
replace subject=2 if discipline=="physics"
replace subject=3 if discipline=="materials science"
replace subject=4 if discipline=="engineering"
replace subject=5 if discipline=="computer science"
replace subject=6 if discipline=="geoscience"

drop if complete==0

gen adnrf=0 
replace adnrf=1 if award_status=="NRF"

gen yrgrad_15=2015-phd_grad

egen meanpb_app=mean(pb_app),by(subject)
egen meanhi_app=mean(hi_app),by(subject)
egen meanct_app=mean(ct_app),by(subject)

gen ratepb_app=(pb_app-meanpb_app)/meanpb_app
gen ratehi_app=(hi_app-meanhi_app)/meanhi_app
gen ratect_app=(ct_app-meanct_app)/meanct_ap

//nrf
probit nrf ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n5.xls,replace sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit nrf ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n5.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit nrf ratehi_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n5.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit nrf ratehi_app ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n5.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit nrf ratehi_app ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n5.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit nrf ratehi_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n5.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit nrf ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n5.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

//adnrf
drop if award_status=="Withdraw"

probit adnrf ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n1.xls,replace sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n1.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n1.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n1.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n1.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n1.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app, vce(robust)
margins, dydx(*) post
outreg2 using n1.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)



probit adnrf ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2011, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,replace sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2011, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2011, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2011, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2011, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2011, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2011, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)


probit adnrf ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2010, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,replace sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2010, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2010, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2010, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2010, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2010, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2010, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)


probit adnrf ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2009, vce(robust)
margins, dydx(*) post
outreg2 using n4.xls,replace sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2009, vce(robust)
margins, dydx(*) post
outreg2 using n4.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2009, vce(robust)
margins, dydx(*) post
outreg2 using n4.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2009, vce(robust)
margins, dydx(*) post
outreg2 using n4.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2009, vce(robust)
margins, dydx(*) post
outreg2 using n4.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratehi_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2009, vce(robust)
margins, dydx(*) post
outreg2 using n4.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)

probit adnrf ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app if announce<=2009, vce(robust)
margins, dydx(*) post
outreg2 using n4.xls,append sortvar (ratepb_app ratect_app ratehi_app) dec(3)


probit adnrf hi_app pb_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==0, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,replace sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf hi_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==0, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf hi_app pb_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==0, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf hi_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==0, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf pb_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==0, vce(robust)
margins, dydx(*) post
outreg2 using n2.xls,append sortvar (hi_app pb_app ct_app) dec(3)




probit adnrf hi_app pb_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==1, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,replace sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf hi_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==1, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf hi_app pb_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==1, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf hi_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==1, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (hi_app pb_app ct_app) dec(3)

probit adnrf pb_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app if field==1, vce(robust)
margins, dydx(*) post
outreg2 using n3.xls,append sortvar (hi_app pb_app ct_app) dec(3)




/*gen field=0 if subject==0
replace field=1 if subject>=1 & subject <=3
replace field=2 if subject==4
replace field=3 if subject==5
replace field=4 if subject==6

gen adnap=0 if award_status=="Neither"
replace adnap=1 if award_status=="NAP"

label define awardnrf 0 "Awarded NRF" 1 "Not Awarded"
label values adnrf awardnrf

label define acptnrf 0 "NRF" 1 "Non-NRF"
label values nrf acptnrf

gen yranc_now=2015-announce

gen dtahi_anc_now=hi_2015-hi_anc
gen dtapb_anc_now=pb_2015-pb_anc
gen dtact_anc_now=ct_2015-ct_anc
 
gen avehi_anc_now=dtahi_anc_now/yranc_now
gen avepb_anc_now=dtapb_anc_now/yranc_now
gen avect_anc_now=dtact_anc_now/yranc_now

gen avehi_anc=hi_anc/(announce-first_pb)
gen avepb_anc=pb_anc/(announce-first_pb)
gen avect_anc=ct_anc/(announce-first_pb)

gen rrhi=avehi_anc_now/avehi_anc
gen rrpb=avepb_anc_now/avepb_anc
gen rrct=avect_anc_now/avect_anc

egen meanavehi_anc=mean(avehi_anc), by(subject)
egen meanavepb_anc=mean(avepb_anc), by(subject)
egen meanavect_anc=mean(avect_anc), by(subject)

gen ravehi_anc=avehi_anc/meanavehi_anc
gen ravepb_anc=avepb_anc/meanavepb_anc
gen ravect_anc=avect_anc/meanavect_anc

reg avehi_anc_now nrf c.avepb_anc#i.subject i.subject i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014, vce(robust)
outreg2 using n6.xls,replace dec(3) adjr2
estat vif
estat ovtest

reg avepb_anc_now nrf c.avepb_anc#i.subject i.subject i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014, vce(robust)
outreg2 using n6.xls,append dec(3) adjr2

reg avect_anc_now nrf c.avect_anc#i.subject i.subject i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014, vce(robust)
outreg2 using n6.xls,append dec(3) adjr2


reg avehi_anc_now nrf avehi_anc avepb_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,replace dec(3) adjr2

reg avehi_anc_now nrf avehi_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avehi_anc_now nrf avepb_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avehi_anc_now nrf avehi_anc avepb_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avehi_anc_now nrf avehi_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avehi_anc_now nrf avepb_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avehi_anc_now nrf avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 


reg avepb_anc_now nrf avehi_anc avepb_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avepb_anc_now nrf avehi_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2

reg avepb_anc_now nrf avepb_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avepb_anc_now nrf avehi_anc avepb_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avepb_anc_now nrf avehi_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avepb_anc_now nrf avepb_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avepb_anc_now nrf avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2


reg avect_anc_now nrf avehi_anc avepb_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2

reg avect_anc_now nrf avehi_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avect_anc_now nrf avepb_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avect_anc_now nrf avehi_anc avepb_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avect_anc_now nrf avehi_anc avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avect_anc_now nrf avepb_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2 

reg avect_anc_now nrf avect_anc i.arwu_phd i.arwu_insapp male yrgrad_15 if announce<2014 & field==0,vce(robust)
outreg2 using n5.xls,append dec(3) adjr2

*/



fstar ratehi_app award

graph bar (mean) ratepb_app, over(adnrf) nofill blabel(bar, format(%5.2f)) ytitle(Publication Ratio at Time of Application) ylabel(0(-.1).1, angle( horizontal)) 

graph bar (mean) ratehi_app, over(adnrf) nofill blabel(bar, format(%5.2f)) ytitle(H-index Ratio at Time of Application) ylabel(0(-.1).1, angle( horizontal)) 


graph bar (mean) ratepb_app, over(award_status) nofill blabel(bar, format(%5.2f)) ytitle(Publication Ratio at Time of Application) ylabel(0(-.1).1, angle( horizontal)) 
graph bar (mean) ratehi_app, over(award_status) nofill blabel(bar, format(%5.2f)) ytitle(H-index Ratio at Time of Application) ylabel(0(-.1).1, angle( horizontal)) 
graph bar (mean) ratect_app, over(award_status) nofill blabel(bar, format(%5.2f)) ytitle(Citation Ratio at Time of Application) ylabel(0(-.1).1, angle( horizontal)) 









graph bar (mean) pb_app if area==0, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(No. of Publications at Time of Application) ylabel(0(10)30, angle( horizontal)) 
graph bar (mean) hi_app if area==0, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(H-index at Time of Application) ylabel(0(2)12, angle( horizontal)) legend(off)

graph bar (mean) pb_app if area==1, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(No. of Publications at Time of Application) ylabel(0(10)30, angle( horizontal)) 
graph bar (mean) hi_app if area==1, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(H-index at Time of Application) ylabel(0(2)12, angle( horizontal)) legend(off)



graph bar (mean) pb_app, over(award_status) nofill blabel(bar, format(%5.1f)) ytitle(No. of Publications at Time of Application) ylabel(0(10)30, angle( horizontal)) 

graph bar (mean) hi_app, over(award_status) nofill blabel(bar, format(%5.1f)) ytitle(H-index at Time of Application) ylabel(0(2)12, angle( horizontal)) legend(off)

graph bar (mean) pb_app, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(No. of Publications at Time of Application) ylabel(0(10)30, angle( horizontal)) 

graph bar (mean) hi_app, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(H-index at Time of Application) ylabel(0(2)12, angle( horizontal)) legend(off)


graph bar (mean) hi_app, over(discipline,  sort(1) descending) nofill blabel(bar, format(%5.1f)) ytitle(H-index at time of application) ylabel(0(2)14, angle( horizontal)) legend(off)

graph bar (mean) pb_app, over(discipline,  sort(1) descending) nofill blabel(bar, format(%5.1f)) ytitle(No. of publications at time of application) ylabel(0(10)60, angle( horizontal)) legend(off)

graph bar (mean) ct_app, over(discipline,  sort(1) descending) nofill blabel(bar, format(%5.1f)) ytitle(Ave. # of citations at time of application) ylabel(0(5)22, angle( horizontal)) legend(off)



graph bar (mean) hi_app pb_app, over(discipline,  sort(1) descending) nofill blabel(bar, format(%5.1f)) ytitle(H-index and # of publications at application) ylabel(0(20)80, angle( horizontal)) legend(on)

















program ttest
args index

sdtest `index' if subject==2|subject==4, by(adnrf)                              
if r(p)>0.05 {                                               
ttest `index' if subject==2|subject==4, by(adnrf)                               
}                                                            
else {                                                       
ttest `index' subject==2|subject==4, by(adnrf) unequal                          
}
end 

ttest "pb_app"
ttest "hi_app"




probit adnrf ratehi_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
margins, dydx(*)
outreg2 using n6.xls,replace sortvar (ratehi_app ratepb_app ratect_app)

probit adnrf ratehi_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
margins, dydx(*)
outreg2 using n6.xls,append sortvar (ratehi_app ratepb_app ratect_app)

probit adnrf ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
margins, dydx(*)
outreg2 using n6.xls,append sortvar (ratehi_app ratepb_app ratect_app)





probit adnap ratehi_app ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
outreg2 using n6.xls,replace sortvar (ratehi_app ratepb_app ratect_app)
estat vif
estat ovtest

test ratehi_app ratepb_app ratect_app 
test 1.arwu_phd 2.arwu_phd 3.arwu_phd 1.arwu_insapp 2.arwu_insapp 3.arwu_insapp male

probit adnap ratehi_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
outreg2 using n6.xls,append sortvar (ratehi_app ratepb_app ratect_app)

probit adnap ratehi_app ratepb_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
outreg2 using n6.xls,append sortvar (ratehi_app ratepb_app ratect_app)

probit adnap ratehi_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
outreg2 using n6.xls,append sortvar (ratehi_app ratepb_app ratect_app)

probit adnap ratepb_app ratect_app i.subject i.arwu_phd i.arwu_insapp male yrgrad_app , vce(robust)
outreg2 using n6.xls,append sortvar (ratehi_app ratepb_app ratect_app)



















graph bar (mean) pb_app if subject==1, over(award_status) nofill blabel(bar, format(%5.1f)) ytitle(No. of publications at time of application-Life Sciences) ylabel(0(5)20, angle( horizontal)) legend(off)
graph bar (mean) pb_app if subject==2|subject==4, over(award_status) nofill blabel(bar, format(%5.1f)) ytitle(No. of publications when apply-Physics and Material Science) ylabel(0(10)55, angle( horizontal)) legend(off)


graph bar (mean) hi_app if subject==1, over(award_status) nofill blabel(bar, format(%5.1f)) ytitle(H-index at time of application-Life Sciences) ylabel(0(2)10, angle( horizontal)) legend(off)
graph bar (mean) hi_app if subject==2|subject==4, over(award_status) nofill blabel(bar, format(%5.1f)) ytitle(H-index when apply-Physics and Material Science) ylabel(0(2)14, angle( horizontal)) legend(off)


fvset base 2 award
reg pb_app i.award if subject==1, cl(apply)
outreg2 using n0.xls,replace
reg pb_app i.award if subject==2|subject==4, cl(apply)
outreg2 using n0.xls,append
reg hi_app i.award if subject==1, cl(apply)
outreg2 using n0.xls,append
reg hi_app i.award if subject==2|subject==4, cl(apply)
outreg2 using n0.xls,append




















graph bar (mean) pb_app if subject==1, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(No. of publications at time of application-Life Sciences) ylabel(0(5)20, angle( horizontal)) legend(off)
graph bar (mean) pb_app if subject==2|subject==4, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(No. of publications when apply-Physics and Material Science) ylabel(0(10)55, angle( horizontal)) legend(off)

graph bar (mean) hi_app if subject==1, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(H-index at time of application-Life Sciences) ylabel(0(2)10, angle( horizontal)) legend(off)
graph bar (mean) hi_app if subject==2|subject==4, over(adnrf) nofill blabel(bar, format(%5.1f)) ytitle(H-index when apply-Physics and Material Science) ylabel(0(2)12, angle( horizontal)) legend(off)

program ttest2
args index

sdtest `index' if subject==2|subject==4, by(adnrf)                              
if r(p)>0.05 {                                               
ttest `index' if subject==2|subject==4, by(adnrf)                               
}                                                            
else {                                                       
ttest `index' subject==2|subject==4, by(adnrf) unequal                          
}
end 

ttest2 "pb_app"
ttest2 "hi_app"


reg hi_app adnrf if subject==1, cl(apply)
outreg2 using n0.xls,replace
reg pb_app adnrf if subject==1, cl(apply)
outreg2 using n0.xls,append
reg hi_app adnrf if subject==2|subject==4, cl(apply)
outreg2 using n0.xls,append
reg pb_app adnrf if subject==2|subject==4, cl(apply)
outreg2 using n0.xls,append


reg adnrf hi_app pb_app i.subject i.arwu_phd male yrgrad_app yrgrad_appsq, cl(apply)
outreg2 using n2.xls,replace

reg adnap hi_app pb_app i.subject i.arwu_phd male yrgrad_app yrgrad_appsq, cl(apply)
outreg2 using n2.xls,append



reg adnrf hi_app pb_app male yrgrad_app yrgrad_appsq  if subject==1, cl(apply)
outreg2 using n2.xls,replace

reg adnrf hi_app pb_app male yrgrad_app yrgrad_appsq if subject==2|subject==4, cl(apply)
outreg2 using n2.xls,append

probit adnrf hi_app pb_app male yrgrad_app yrgrad_appsq if subject==1, cl(apply)
margins, dydx(*)
outreg2 using n3.xls,replace

probit adnrf hi_app pb_app male yrgrad_app yrgrad_appsq if subject==2|subject==4, cl(apply)
margins, dydx(*)
outreg2 using n3.xls,append


reg adnap hi_app pb_app male i.subject yrgrad_app yrgrad_appsq, cl(subject)
outreg2 using n6.xls,replace

reg ad hi_app pb_app male i.subject yrgrad_app yrgrad_appsq, cl(subject)
outreg2 using n6.xls,replace


reg adnrf male i.subject yrgrad_app yrgrad_appsq, cl(apply)
outreg2 using n1.xls,replace

reg adnrf hi_app pb_app male yrgrad_app yrgrad_appsq if subject==0, cl(apply)
outreg2 using n2.xls,replace

forvalues i=1/6{
reg adnrf hi_app pb_app male yrgrad_app yrgrad_appsq if subject==`i', cl(apply)
outreg2 using n2.xls,append
}

reg adnrf avehi_app avepb_app male yrgrad_app yrgrad_appsq if subject==0, cl(apply)
outreg2 using n3.xls,replace

forvalues i=1/6{
reg adnrf avehi_app avepb_app male yrgrad_app yrgrad_appsq if subject==`i', cl(apply)
outreg2 using n3.xls,append
}

reg adnrf hi_app pb_app male yrgrad_app yrgrad_appsq, cl(subject)
outreg2 using n4.xls,replace


reg adnrf hi_app pb_app male i.subject yrgrad_app yrgrad_appsq, cl(subject)
outreg2 using n5.xls,replace

reg adnrf hi_app pb_app male i.subject yrgrad_app yrgrad_appsq, cl(apply)
outreg2 using n5.xls,append



probit adnrf hi_app i.arwu_phd i.arwu_insapp male yrgrad_app yrgrad_appsq if area==0, vce(robust)
outreg2 using n9.xls,replace sortvar (hi_app pb_app ct_app)

probit adnrf hi_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app yrgrad_appsq if area==0, vce(robust)
outreg2 using n9.xls,append sortvar (hi_app pb_app ct_app)

probit adnrf pb_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app yrgrad_appsq if area==0, vce(robust)
outreg2 using n9.xls,append sortvar (hi_app pb_app ct_app)

probit adnrf hi_app i.arwu_phd i.arwu_insapp male yrgrad_app yrgrad_appsq if area==1, vce(robust)
outreg2 using n9.xls,append sortvar (hi_app pb_app ct_app)

probit adnrf hi_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app yrgrad_appsq if area==1, vce(robust)
outreg2 using n9.xls,append sortvar (hi_app pb_app ct_app)

probit adnrf pb_app ct_app i.arwu_phd i.arwu_insapp male yrgrad_app yrgrad_appsq if area==1, vce(robust)
outreg2 using n9.xls,append sortvar (hi_app pb_app ct_app)















































log close
