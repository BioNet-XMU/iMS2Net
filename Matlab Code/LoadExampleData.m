load ExampleData_1.mat;
load ExampleData_2.mat;
load ExampleData_3.mat;
load ExampleData_4.mat;
load ExampleData_5.mat;

msiDataOrgan_Exp = [msiDataOrgan_Exp_1;msiDataOrgan_Exp_2];
msiDataOrgan_Ctr = [msiDataOrgan_Ctr_1;msiDataOrgan_Ctr_2];

clear msiDataOrgan_Exp_1 msiDataOrgan_Exp_2 msiDataOrgan_Ctr_1 msiDataOrgan_Ctr_2;