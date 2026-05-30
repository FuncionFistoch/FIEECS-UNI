%Definicion de variables del sistema
var piF_H ${\pi^F_H}$ (long_name = 'Inflacion Formal Domestica')
    piF ${\pi^F}$ (long_name = 'Inflacion Formal')
    xF ${x^F}$ (long_name = 'Brecha del producto formal')
    yF ${y^F}$ (long_name = 'Producto Formal')
    yF_nat ${\bar y^F}$ (long_name = 'Producto Formal Natural')
    r_nat ${\bar r}$ (long_name = 'Tasa de interes natural')
    r $r$ (long_name = 'Tasa de interes nominal')
    s $s$ (long_name = 'Terminos de Intercambio')
    piI_H ${\pi^I_H}$ (long_name = 'Inflacion Informal Domestica')
    xI ${x^I}$ (long_name = 'Brecha del producto informal')
    x ${x}$ (long_name = 'Brecha agregada del producto')
    yI ${y^I}$ (long_name = 'Producto Informal')
    yI_nat ${\bar y^I}$ (long_name = 'Porducto Informal Natural')
    pi_H ${\pi_H}$ (long_name = 'Inflacion Domestica Agregada')
    e $e$ (long_name = 'Tipo de cambio nominal')
    y_mundo ${y^*}$ (long_name = 'Producto mundial')
    pi_mundo ${\pi^*}$ (long_name = 'Inflación mundial')
    r_mundo ${\r^*}$ (long_name = 'Tasa de Interes mundial')
    nI ${n^I}$ (long_name = 'Empleo Informal')
    nF ${n^F}$ (long_name = 'Empleo Formal')
    wI ${w^I}$ (long_name = 'Salario Informal')
    wF ${w^F}$ (long_name = 'Salario Formal')
    aI ${a^I}$ (long_name = 'Productividad Informal')
    aF ${a^F}$ (long_name = 'Productividad Formal')
    cI ${c^I}$ (long_name = 'Consumo Informal')
    cF ${c^F}$ (long_name = 'Consumo Formal')
    ;
%Variables exogenas
varexo 
    shock_mundial ${\varepsilon^{*}}$ (long_name = 'Shock de Produccion Mundial')
    shock_aI ${\varepsilon_I}$ (long_name = 'Shock de Productividad Informal')
    shock_aF ${\varepsilon_F}$ (long_name = 'Shock de Productividad Formal')
    shock_r_mundial ${\varepsilon_r}$ (long_name = 'Shock de Interes Mundial') 
    ;
%Parametros Profundos
parameters sigma $\sigma$ (long_name = 'Aversion al riesgo')
    eta $\eta$ (long_name = 'Elasticidad Sustitucion Hogar Foraneo')
    tau $\tau$ (long_name = 'Subsidio por Empleo')
    gamma $\gamma$ (longa_name = 'Elasticidad Sustitucion entre Foraneos')
    varphi $\varphi$ (long_name = 'Elasticidad Laboral')
    epsilon $\varepsilon$ (long_name = 'Elasticidad de Sustitucion')
    theta $\theta$ (long_name = 'Parametro de Calvo')
    phi $\phi$ (long_name = 'Parametro de Rotemberg')
    beta $\beta$ (long_name = 'Factor de Descuento')
    alpha $\alpha$ (long_name = 'Grado de apertura')
    lambda $\lambda$ (long_name = 'Grado de informalidad')
    rhoaF $\rho^F_a$ (long_name = 'Autocorrelacion PTF Formales')
    rhoaI $\rho^I_a$ (long_name = 'Autocorrelacion PTF Informales')
    rho_mundo ${\rho^{*}}$ (long_name = 'Autocorroleacion Producto Mundial')
    rho_interes_mundo ${\rho_{r}}$ (long_name = 'Autocorroleacion Interes Mundial')
    zeta ${\zeta}$ (long_name = 'Prima de Riesgo Pais')
;
%Definir Parametros Profundos
sigma = 1;
eta = 1;
gamma = 1;
varphi = 3;
tau = 0.3;
epsilon = 6;
theta = 0.75;
phi = 0.75;
beta = 0.99;
alpha = 0.4;
lambda = 0.7;
rhoaF = 0.9;
rhoaI = 0.9;
zeta = 0.14;
rho_mundo = 0.86;
rho_interes_mundo = 0.75;
%Ecuaciones del Modelo
model(linear);
%Parametros Auxiliares
#rho = beta^(-1)-1;
#omega = sigma*gamma + (1-alpha)*(sigma*eta-1);
#sigma_a = sigma/((1-alpha)+alpha*omega);
#Theta = (sigma*gamma-1)+(1-alpha)*(sigma*eta-1);
#kappa_formal = (epsilon-1)/(phi)*(sigma_a+varphi);
#kappa_informal = ((1-beta*theta)*(1-theta)/theta)*(sigma+varphi);
#mu = log(epsilon/(epsilon-1));
#v = -log(1-tau);
#Omega = (v-mu)/(sigma_a+varphi);
#Gamma = (1+varphi)/(sigma_a+varphi);
#Psi = -Theta*sigma_a/(sigma_a+varphi);
%Ecuaciones del Sector Formal
[name = 'Curva IS dinamica Formal']
xF = xF(+1) - sigma_a^(-1)*(r - piF_H(+1) - r_nat);
[name = 'NKCP Formal']
piF_H = beta*piF_H(+1) + kappa_formal*xF;
[name = 'Tasa natural en el modelo NeoKeynesiano']
r_nat = rho-sigma_a*Gamma*(1-rhoaF)*aF + alpha*sigma_a*(Theta+Psi)*(y_mundo(+1)-y_mundo);
[name = 'Producto Formal natural']
yF_nat = Omega + Gamma*aF + alpha*Psi*y_mundo;
[name = 'Brecha del producto formal']
xF = yF - yF_nat;
[name = 'Relacion producto formal y el mundo exterior']
yF = y_mundo + sigma_a^(-1)*s;
[name = 'Relacion de la inflacion y el mundo exterior']
piF = piF_H +alpha*(s-s(-1));
[name = 'Relacion de los Terminos de Intercambio y la Inflacion']
s = s(-1) + e - e(-1) - piF_H; 
[name = 'Ecuacion del producto desde la Oferta']
yF = aF + nF;
[name = 'El equilibrio formal']
yF = cF + alpha*omega/sigma*s;
[name = 'El salario nominal formal']
wF = sigma*cF + varphi*nF;
[name = 'Inflacion mundial nula']
pi_mundo = 0;
[name = 'Proceso Estocastico del Interes Mundial']
r_mundo = rho_interes_mundo*r_mundo(-1) + shock_r_mundial;
[name = 'Proceso Estocastico de la Tecnologia Formal']
aF = rhoaF*aF(-1) + shock_aF;
[name = 'Proceso Estocastico del Producto Mundial']
y_mundo = rho_mundo*y_mundo(-1) + shock_mundial;
%Ecuaciones del sector informal
[name = 'El salario real informal']
wI = sigma*cI + varphi*nI;
[name = 'Producto Informal desde la Oferta']
yI = aI + nI;
[name = 'Proceso Estocastico de la Tecnologia Informal']
aI = rhoaI*aI(-1) + shock_aI;
[name = 'El equilibrio informal']
yI = cI;
[name = 'El producto informal natural']
yI_nat = -mu/(sigma + varphi)-(varphi-1)/(sigma+varphi)*aI;
[name = 'Brecha del Producto Informal']
xI = yI - yI_nat;
[name = 'NKCP Informal']
piI_H = beta*piI_H(+1) + kappa_informal*xI;
[name = 'Composicion Completa de la Inflacion']
pi_H = lambda*piI_H + (1-lambda)*piF_H;
[name = 'Composicion Completa de la Brecha del Producto']
x = lambda*xI + (1-lambda)*xF; 
%Ecuaciones del Banco Central
[name = 'Solucion Optima del Banco Central']
r = r(-1) + 1.2*x + 1.4*pi_H;
[name = 'UIP con prima de riesgo']
r = r_mundo + e(+1)-e-zeta*e; %  Schmitt-Grohé & Uribe (2003)
end;

%Shocks
shocks;
var shock_mundial = 1;
end;

write_latex_dynamic_model;
write_latex_parameter_table;
write_latex_definitions;

resid;
steady;
check;

stoch_simul(order=1, irf=20);

