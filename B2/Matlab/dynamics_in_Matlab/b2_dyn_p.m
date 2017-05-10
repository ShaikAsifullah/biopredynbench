function dxdt = b2_dyn_p(t, x, p)

if size(t,1) ~= 1 % this is because some solvers use (x,t) and others (t,x)
    newt = x;
    x = t;
    t = newt;
end

%% PARAMETERS
kALDOdhap			= p(1);
kALDOeq				= p(2);
kALDOfdp			= p(3);
kALDOgap			= p(4);
kALDOgapinh			= p(5);
KDAHPSe4p			= p(6);
KDAHPSpep			= p(7);
KENOeq				= p(8);
KENOpep				= p(9);
KENOpg2				= p(10);
KG1PATatp			= p(11);
KG1PATfdp			= p(12);
KG1PATg1p			= p(13);
KG3PDHdhap			= p(14);
KG6PDHg6p			= p(15);
KG6PDHnadp			= p(16);
KG6PDHnadphg6pinh	= p(17);
KG6PDHnadphnadpinh	= p(18);
KGAPDHeq			= p(19);
KGAPDHgap			= p(20);
KGAPDHnad			= p(21);
KGAPDHnadh			= p(22);
KGAPDHpgp			= p(23);
KPDHpyr				= p(24);
KpepCxylasefdp		= p(25);
KpepCxylasepep		= p(26);
KPFKadpa			= p(27);
KPFKadpb			= p(28);
KPFKadpc			= p(29);
KPFKampa			= p(30);
KPFKampb			= p(31);
KPFKatps			= p(32);
KPFKf6ps			= p(33);
KPFKpep				= p(34);
KPGDHatpinh			= p(35);
KPGDHnadp			= p(36);
KPGDHnadphinh		= p(37);
KPGDHpg				= p(38);
KPGIeq				= p(39);
KPGIf6p				= p(40);
KPGIf6ppginh		= p(41);
KPGIg6p				= p(42);
KPGIg6ppginh		= p(43);
KPGKadp				= p(44);
KPGKatp				= p(45);
KPGKeq				= p(46);
KPGKpg3				= p(47);
KPGKpgp				= p(48);
KPGluMueq			= p(49);
KPGluMupg2			= p(50);
KPGluMupg3			= p(51);
KPGMeq				= p(52);
KPGMg1p				= p(53);
KPGMg6p				= p(54);
KPKadp				= p(55);
KPKamp				= p(56);
KPKatp				= p(57);
KPKfdp				= p(58);
KPKpep				= p(59);
KPTSa1				= p(60);
KPTSa2				= p(61);
KPTSa3				= p(62);
KPTSg6p				= p(63);
KR5PIeq				= p(64);
KRPPKrib5p			= p(65);
KRu5Peq				= p(66);
KSerSynthpg3		= p(67);
KSynth1pep			= p(68);
KSynth2pyr			= p(69);
KTAeq				= p(70);
kTISdhap			= p(71);
kTISeq				= p(72);
kTISgap				= p(73);
KTKaeq				= p(74);
KTKbeq				= p(75);
LPFK				= p(76);
LPK					= p(77);
nDAHPSe4p			= p(78);
nDAHPSpep			= p(79);
nG1PATfdp			= p(80);
nPDH				= p(81);
npepCxylasefdp		= p(82);
nPFK				= p(83);
nPK					= p(84);
nPTSg6p				= p(85);
rmaxALDO			= p(86);
rmaxDAHPS			= p(87);
rmaxENO				= p(88);
rmaxG1PAT			= p(89);
rmaxG3PDH			= p(90);
rmaxG6PDH			= p(91);
rmaxGAPDH			= p(92);
rmaxMetSynth		= p(93);
rmaxMurSynth		= p(94);
rmaxPDH				= p(95);
rmaxpepCxylase		= p(96);
rmaxPFK				= p(97);
rmaxPGDH			= p(98);
rmaxPGI				= p(99);
rmaxPGK				= p(100);
rmaxPGluMu			= p(101);
rmaxPGM				= p(102);
rmaxPK				= p(103);
rmaxPTS				= p(104);
rmaxR5PI			= p(105);
rmaxRPPK			= p(106);
rmaxRu5P			= p(107);
rmaxSerSynth		= p(108);
rmaxSynth1			= p(109);
rmaxSynth2			= p(110);
rmaxTA				= p(111);
rmaxTIS				= p(112);
rmaxTKa				= p(113);
rmaxTKb				= p(114);
rmaxTrpSynth		= p(115);
VALDOblf			= p(116);

cfeed				= 110.96;
Dil					= 2.78e-05;
mu					= 2.78e-05;
cytosol				= 1;
extracellular		= 1;


%% STATES

cdhap				= x(1);
ce4p				= x(2);
cf6p				= x(3);
cfdp				= x(4);
cg1p				= x(5);
cg6p				= x(6);
cgap				= x(7);
cpep				= x(8);
cpg					= x(9);
cpg2				= x(10);
cpg3				= x(11);
cpgp				= x(12);
cpyr				= x(13);
crib5p				= x(14);
cribu5p				= x(15);
csed7p				= x(16);
cxyl5p				= x(17);
cglcex				= x(18);

cadp				= 0.582 + 1.73 * 2.731 ^ (-0.15 * t) * (0.12 * t + 0.000214 * t ^ 3);
camp				= 0.123 + 7.25 * (t / (7.25 + 1.47 * t + 0.17 * t ^ 2)) + 1.073 / (1.29 + 8.05 * t);
catp				= 4.27 - 4.163 * (t / (0.657 + 1.43 * t + 0.0364 * t ^ 2));
cnad				= 1.314 + 1.314 * 2.73 ^ (-0.0435 * t - 0.342) - (t + 7.871) * (2.73 ^ (-0.0218 * t - 0.171) / (8.481 + t));
cnadh				= 0.0934 + 0.00111 * 2.371 ^ (-0.123 * t) * (0.844 * t + 0.104 * t ^ 3);
cnadp				= 0.159 - 0.00554 * (t / (2.8 - 0.271 * t + 0.01 * t ^ 2)) + 0.182 / (4.82 + 0.526 * t);
cnadph				= 0.062 + 0.332 * 2.718 ^ (-0.464 * t) * (0.0166 * t ^ 1.58 + 0.000166 * t ^ 4.73 + 0.1312 * 10 ^ (-9) * t ^ 7.89 + 0.1362 * 10 ^ (-12) * t ^ 11 + 0.1233 * 10 ^ (-15) * t ^ 14.2);


%% DYNAMICS

vALDO				= cytosol * rmaxALDO * (cfdp - cgap * cdhap / kALDOeq) / (kALDOfdp + cfdp + kALDOgap * cdhap / (kALDOeq * VALDOblf) + kALDOdhap * cgap / (kALDOeq * VALDOblf) + cfdp * cgap / kALDOgapinh + cgap * cdhap / (VALDOblf * kALDOeq));
vDAHPS				= cytosol * rmaxDAHPS * ce4p ^ nDAHPSe4p * cpep ^ nDAHPSpep / ((KDAHPSe4p + ce4p ^ nDAHPSe4p) * (KDAHPSpep + cpep ^ nDAHPSpep));
vDHAP				= cytosol * mu * cdhap;
vE4P				= cytosol * mu * ce4p;
vENO				= cytosol * rmaxENO * (cpg2 - cpep / KENOeq) / (KENOpg2 * (1 + cpep / KENOpep) + cpg2);
vEXTER				= extracellular * Dil * (cfeed - cglcex);
vG1PAT				= cytosol * rmaxG1PAT * cg1p * catp * (1 + (cfdp / KG1PATfdp) ^ nG1PATfdp) / ((KG1PATatp + catp) * (KG1PATg1p + cg1p));
vG3PDH				= cytosol * rmaxG3PDH * cdhap / (KG3PDHdhap + cdhap);
vG6P				= cytosol * mu * cg6p;
vG6PDH				= cytosol * rmaxG6PDH * cg6p * cnadp / ((cg6p + KG6PDHg6p) * (1 + cnadph / KG6PDHnadphg6pinh) * (KG6PDHnadp * (1 + cnadph / KG6PDHnadphnadpinh) + cnadp));
vGAP				= cytosol * mu * cgap;
vGAPDH				= cytosol * rmaxGAPDH * (cgap * cnad - cpgp * cnadh / KGAPDHeq) / ((KGAPDHgap * (1 + cpgp / KGAPDHpgp) + cgap) * (KGAPDHnad * (1 + cnadh / KGAPDHnadh) + cnad));
vGLP				= cytosol * mu * cg1p;
vMURSyNTH			= cytosol * rmaxMurSynth;
vMethSynth			= cytosol * rmaxMetSynth;
vPDH				= cytosol * rmaxPDH * cpyr ^ nPDH / (KPDHpyr + cpyr ^ nPDH);
vPEP				= cytosol * mu * cpep;
vPFK				= cytosol * rmaxPFK * catp * cf6p / ((catp + KPFKatps * (1 + cadp / KPFKadpc)) * (cf6p + KPFKf6ps * (1 + cpep / KPFKpep + cadp / KPFKadpb + camp / KPFKampb) / (1 + cadp / KPFKadpa + camp / KPFKampa)) * (1 + LPFK / (1 + cf6p * (1 + cadp / KPFKadpa + camp / KPFKampa) / (KPFKf6ps * (1 + cpep / KPFKpep + cadp / KPFKadpb + camp / KPFKampb))) ^ nPFK));
vPG					= cytosol * mu * cpg;
vPG3				= cytosol * mu * cpg3;
vPGDH				= cytosol * rmaxPGDH * cpg * cnadp / ((cpg + KPGDHpg) * (cnadp + KPGDHnadp * (1 + cnadph / KPGDHnadphinh) * (1 + catp / KPGDHatpinh)));
vPGI				= cytosol * rmaxPGI * (cg6p - cf6p / KPGIeq) / (KPGIg6p * (1 + cf6p / (KPGIf6p * (1 + cpg / KPGIf6ppginh)) + cpg / KPGIg6ppginh) + cg6p);
vPGK				= cytosol * rmaxPGK * (cadp * cpgp - catp * cpg3 / KPGKeq) / ((KPGKadp * (1 + catp / KPGKatp) + cadp) * (KPGKpgp * (1 + cpg3 / KPGKpg3) + cpgp));
vPGM				= cytosol * rmaxPGM * (cg6p - cg1p / KPGMeq) / (KPGMg6p * (1 + cg1p / KPGMg1p) + cg6p);
vPGP				= cytosol * mu * cpgp;
vPK					= cytosol * rmaxPK * cpep * (cpep / KPKpep + 1) ^ (nPK - 1) * cadp / (KPKpep * (LPK * ((1 + catp / KPKatp) / (cfdp / KPKfdp + camp / KPKamp + 1)) ^ nPK + (cpep / KPKpep + 1) ^ nPK) * (cadp + KPKadp));
vPPK				= cytosol * rmaxRPPK * crib5p / (KRPPKrib5p + crib5p);
vPTS				= extracellular * rmaxPTS * cglcex * (cpep / cpyr) / ((KPTSa1 + KPTSa2 * (cpep / cpyr) + KPTSa3 * cglcex + cglcex * (cpep / cpyr)) * (1 + cg6p ^ nPTSg6p / KPTSg6p));
vR5PI				= cytosol * rmaxR5PI * (cribu5p - crib5p / KR5PIeq);
vRIB5P				= cytosol * mu * crib5p;
vRibu5p				= cytosol * mu * cribu5p;
vRu5P				= cytosol * rmaxRu5P * (cribu5p - cxyl5p / KRu5Peq);
vSED7P				= cytosol * mu * csed7p;
vSynth1				= cytosol * rmaxSynth1 * cpep / (KSynth1pep + cpep);
vSynth2				= cytosol * rmaxSynth2 * cpyr / (KSynth2pyr + cpyr);
vTA					= cytosol * rmaxTA * (cgap * csed7p - ce4p * cf6p / KTAeq);
vTIS				= cytosol * rmaxTIS * (cdhap - cgap / kTISeq) / (kTISdhap * (1 + cgap / kTISgap) + cdhap);
vTKA				= cytosol * rmaxTKa * (crib5p * cxyl5p - csed7p * cgap / KTKaeq);
vTKB				= cytosol * rmaxTKb * (cxyl5p * ce4p - cf6p * cgap / KTKbeq);
vTRPSYNTH			= cytosol * rmaxTrpSynth;
vXYL5P				= cytosol * mu * cxyl5p;
vf6P				= cytosol * mu * cf6p;
vfdP				= cytosol * mu * cfdp;
vpepCxylase			= cytosol * rmaxpepCxylase * cpep * (1 + (cfdp / KpepCxylasefdp) ^ npepCxylasefdp) / (KpepCxylasepep + cpep);
vpg2				= cytosol * mu * cpg2;
vpyr				= cytosol * mu * cpyr;
vrpGluMu			= cytosol * rmaxPGluMu * (cpg3 - cpg2 / KPGluMueq) / (KPGluMupg3 * (1 + cpg2 / KPGluMupg2) + cpg3);
vsersynth			= cytosol * rmaxSerSynth * cpg3 / (KSerSynthpg3 + cpg3);

dcdhap				= (vALDO - vDHAP - vG3PDH - vTIS)/cytosol;
dce4p				= (- vDAHPS - vE4P + vTA - vTKB)/cytosol;
dcf6p				= (- 2.0 * vMURSyNTH - vPFK + vPGI + vTA + vTKB - vf6P)/cytosol;
dcfdp				= (- vALDO + vPFK - vfdP)/cytosol;
dcg1p				= (- vG1PAT - vGLP + vPGM)/cytosol;
dcg6p				= (- vG6P - vG6PDH - vPGI - vPGM + 65.0 * vPTS)/cytosol;
dcgap				= (vALDO - vGAP - vGAPDH - vTA + vTIS + vTKA + vTKB + vTRPSYNTH)/cytosol;
dcpep				= (- vDAHPS + vENO - vPEP - vPK - 65.0 * vPTS - vSynth1 - vpepCxylase)/cytosol;
dcpg				= (vG6PDH - vPG - vPGDH)/cytosol;
dcpg2				= (- vENO - vpg2 + vrpGluMu)/cytosol;
dcpg3				= (- vPG3 + vPGK - vrpGluMu - vsersynth)/cytosol;
dcpgp				= (vGAPDH - vPGK - vPGP)/cytosol;
dcpyr				= (vMethSynth - vPDH + vPK + 65.0 * vPTS - vSynth2 + vTRPSYNTH - vpyr)/cytosol;
dcrib5p				= (- vPPK + vR5PI - vRIB5P - vTKA)/cytosol;
dcribu5p			= (vPGDH - vR5PI - vRibu5p - vRu5P)/cytosol;
dcsed7p				= (- vSED7P - vTA + vTKA)/cytosol;
dcxyl5p				= (vRu5P - vTKA - vTKB - vXYL5P)/cytosol;
dcglcex				= (vEXTER - vPTS)/extracellular;

%% OUTPUTS

dxdt				=zeros(18, 1);
dxdt(1)				=dcdhap;
dxdt(2)				=dce4p;
dxdt(3)				=dcf6p;
dxdt(4)				=dcfdp;
dxdt(5)				=dcg1p;
dxdt(6)				=dcg6p;
dxdt(7)				=dcgap;
dxdt(8)				=dcpep;
dxdt(9)				=dcpg;
dxdt(10)			=dcpg2;
dxdt(11)			=dcpg3;
dxdt(12)			=dcpgp;
dxdt(13)			=dcpyr;
dxdt(14)			=dcrib5p;
dxdt(15)			=dcribu5p;
dxdt(16)			=dcsed7p;
dxdt(17)			=dcxyl5p;
dxdt(18)			=dcglcex;