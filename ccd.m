D = ccdesign(2)
D = D(1:12,:)
Tlow = 5;
Thigh = 50;

D(:,1) = 55/2 + D(:,1)*45/2/sqrt(2);

D(:,2) = 15 + 15/sqrt(2)*D(:,2);

disp(D)



order =  randperm(12)

disp(D(order,:))

