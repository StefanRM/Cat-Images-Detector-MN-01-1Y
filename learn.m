function [w] = learn(X, t)
	% Construim ecuatia Ax = b
	A = X' * X;
	b = X' * t;

	[L, U] = doolittle(A); % Factorizam matricea A cu 'Factorizarea Doolittle'
	y = SIT(L, b); % Rezolvam sistemul inferior triunghiular
	w = SST(U, y); % Rezolvam sistemul superior triunghiular
end