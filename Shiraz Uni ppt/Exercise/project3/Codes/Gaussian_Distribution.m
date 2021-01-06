function Px_w=Gaussian_Distribution(x,mu,sigma,d)

 g=((2*pi)^(d/2))*((det(sigma))^(1/2));
 
 Px_w=(1/g)*exp((-1/2)*(x-mu)'*inv(sigma)*(x-mu));
 
end