% high oscillated denoising
% See Experiment 3

clear all, close all
N = 500; L = 300; LL = 100;
ff = -1:0.01:1; [f,w] = jacpts(N+1,-.5,-.5);
GG =  airy(40*ff); G= airy(40*f);
[YY,NOISE] = noisegen(GG,10); [Y,NOISE] = noisegen(G,10);
Lambda = [0 10^(-1) 10^(-2) 10^(-5)];
for l = 0:1:L
    mu(l+1) = 1/Filter(L,l);
end
mu = mu';
for l = 0:L
    for j = 0:N
        A(j+1,l+1) = cos(l*acos(f(j+1)))/sqrt(pi/2);
    end
end
A(:,1) = A(:,1)/sqrt(2);

% plot
Color = [215,25,28;
253,174,97;
254,204,92;
171,217,233;
44,123,182]/255;

fontsize_baseline = 10;
subplot(4,4,1), plot(ff,GG), xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Original function','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'),set(gca, 'YMinorGrid', 'off'),
subplot(4,4,2), plot(ff,YY), xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Noisy function','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'),set(gca, 'YMinorGrid', 'off'),

beta2 = l2_beta(w,A,Y,Lambda(1),L,mu);
p2 = zeros(201,1);
for l = 0:L        
    if l == 0
        F = chebpoly(l,1)/sqrt(pi);
    else
        F = chebpoly(l,1)/sqrt(pi/2);
    end
    p2 = p2+beta2(l+1)*F(ff');
end
subplot(4,4,5),plot(ff,p2),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('$\lambda=0$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'),set(gca, 'YMinorGrid', 'off'),
subplot(4,4,6), plot(ff,abs(GG-p2')),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('Absolute error', 'interpreter','latex','fontsize', fontsize_baseline),...
    title('Error, $\lambda=0$','interpreter','latex'),grid on,box on,...
    axis([-1,1,0,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'),set(gca, 'YMinorGrid', 'off'),
 

beta21 = l2_beta(w,A,Y,Lambda(2),L,mu); beta11 = l1_beta(w,A,Y,Lambda(2),L,mu);
beta22 = l2_beta(w,A,Y,Lambda(3),L,mu); beta12 = l1_beta(w,A,Y,Lambda(3),L,mu);
beta23 = l2_beta(w,A,Y,Lambda(4),L,mu); beta13 = l1_beta(w,A,Y,Lambda(4),L,mu);
p21 = zeros(201,1); p11 = zeros(201,1);
p22 = zeros(201,1); p12 = zeros(201,1);
p23 = zeros(201,1); p13 = zeros(201,1);
for l = 0:L
    if l == 0
        F = chebpoly(l,1)/sqrt(pi);
    else
        F = chebpoly(l,1)/sqrt(pi/2);
    end
    p21 = p21+beta21(l+1)*F(ff');
    p11 = p11+beta11(l+1)*F(ff');
    p22 = p22+beta22(l+1)*F(ff');
    p12 = p12+beta12(l+1)*F(ff');
    p23 = p23+beta23(l+1)*F(ff');
    p13 = p13+beta13(l+1)*F(ff');
end

subplot(4,4,9),plot(ff,p21),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('$\ell_2-\ell_2$ model, $\lambda=10^{-1}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off'),
subplot(4,4,10),plot(ff,abs(GG-p21')),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('Absolute error','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Error, $\ell_2-\ell_2$ model, $\lambda=10^{-1}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,0,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off')
subplot(4,4,13),plot(ff,p11),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$', 'interpreter','latex','fontsize', fontsize_baseline),...
    title('$\ell_2-\ell_1$ model, $\lambda=10^{-1}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off'),
subplot(4,4,14),plot(ff,abs(GG-p11')),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('Absolute error','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Error: $\ell_2-\ell_1$ model, $\lambda=10^{-1}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,0,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off')
subplot(4,4,3),plot(ff,p22),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('$\ell_2-\ell_2$ model, $\lambda=10^{-2}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off'),
subplot(4,4,4),plot(ff,abs(GG-p22')),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('Absolute error','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Error, $\ell_2-\ell_2$ model, $\lambda=10^{-2}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,0,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'),set(gca, 'YMinorGrid', 'off')
subplot(4,4,7),plot(ff,p12),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$', 'interpreter','latex','fontsize', fontsize_baseline),...
    title('$\ell_2-\ell_1$ model, $\lambda=10^{-2}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off'),
subplot(4,4,8), plot(ff,abs(GG-p12')),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('Absolute error','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Error: $\ell_2-\ell_1$ model, $\lambda=10^{-2}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,0,.6]), set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off'),
subplot(4,4,11),plot(ff,p23),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('$\ell_2-\ell_2$ model, $\lambda=10^{-5}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline), set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off'),
subplot(4,4,12), plot(ff,abs(GG-p23')),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('Absolute error','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Error, $\ell_2-\ell_2$ model, $\lambda=10^{-5}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,0,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'),set(gca, 'YMinorGrid', 'off')
subplot(4,4,15),plot(ff,p13),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('$f(x)$', 'interpreter','latex','fontsize', fontsize_baseline),...
    title('$\ell_2-\ell_1$ model, $\lambda=10^{-5}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,-.6,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'), set(gca, 'YMinorGrid', 'off'),
subplot(4,4,16), plot(ff,abs(GG-p13')),xlabel('$x$','interpreter','latex', 'fontsize', fontsize_baseline),ylabel('Absolute error','interpreter','latex', 'fontsize', fontsize_baseline),...
    title('Error: $\ell_2-\ell_1$ model, $\lambda=10^{-5}$','interpreter','latex', 'fontsize', fontsize_baseline),grid on,box on,...
    axis([-1,1,0,.6]),set(gca, 'fontsize', fontsize_baseline),set(gca, 'XMinorGrid', 'off'),set(gca, 'YMinorGrid', 'off')

colormap parula