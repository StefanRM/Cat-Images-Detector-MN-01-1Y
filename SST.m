function x = SST(A, b)
	% Rezolvarea sistemelor superior triunghiulare (Ax = b)
	[n n] = size(A);
	x = zeros(n, 1);
	for i = n: -1 : 1
		s = 0;
		for j = i+1 : n
			s = s + A(i, j)*x(j, 1);
		endfor
		if (A(i, i) != 0)
			x(i, 1) = (b(i, 1) - s) / A(i, i);
		else
			x(i, 1) = 0;
		endif
	endfor
endfunction