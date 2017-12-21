function [hsv] = hsvHistogram(path_to_image, count_bins)
	% listele in functie de proprietati
	h_count = zeros(1, count_bins);
	s_count = zeros(1, count_bins);
	v_count = zeros(1, count_bins);

	% citirea celor 3 matrici in functie de culori
	% se efectueaza impartirea corespunzatoare transformarii RGB in HSV
	ColorMatrix = imread(path_to_image);
	r = double(ColorMatrix(:, :, 1)) / 255;
	g = double(ColorMatrix(:, :, 2)) / 255;
	b = double(ColorMatrix(:, :, 3)) / 255;

	% transformarea in HSV
	[m, n] = size(r);
	h = zeros(m, n);
	s = zeros(m,n);
	v = zeros(m,n);

	Cmax = max(r, max(g, b));
	Cmin = min(r, min(g, b));
	delta = Cmax - Cmin;

	% matricile care tin evidenta pozitiilor elementelor maxime din Cmax in functie de matricea din care provenea elementul maxim
	r_max = (Cmax == r);
	g_max = (Cmax == g);
	b_max = (Cmax == b);

	delta_0 = (delta == 0); % matrice care tine evidenta zero-urilor din delta ---> pentru impartirile la 0

	% pentru H
	% se formeaza matrici pentru toate cele 3 cazuri de maxime R', G', B'
	Cmax_r = 60 * mod((g - b) ./ delta, 6);
	Cmax_g = 60 * ((b - r) ./ delta + 2);
	Cmax_b = 60 * ((r - g) ./ delta + 4);

	% din matricile formate anteriror se extrag doar elementele care corespund cu elementele maxime din cazuri, fiind puse in pozitia corespunzatoare in h
	h(r_max) = Cmax_r(r_max);
	h(g_max) = Cmax_g(g_max);
	h(b_max) = Cmax_b(b_max);
	h(delta_0) = 0; % valorile rezultate din impartirea cu zero sunt inlocuite cu 0 (conditie in algoritm)
	
	h = h / 360;

	% pentru S
	Cmax_0 = (Cmax == 0); % matrice care tine evidenta zero-urilor din Cmax ---> pentru impartirile la 0
	s = delta ./ Cmax;
	s(Cmax_0) = 0; % valorile rezultate din impartirea cu zero sunt inlocuite cu 0 (conditie in algoritm)

	% pentru V
	v = Cmax;

	d = 1.01 / count_bins; % nlungime intervale (101 / 100 -> datorita lui S si V, H e deja normat)

	% se formeaza 3 liste pentru cele count_bins intervale
	for i = 0 : (count_bins - 1)
		h_count(i + 1) = sum(sum((h >= (i * d) & h < ((i + 1) * d))));
		s_count(i + 1) = sum(sum((s >= (i * d) & s < ((i + 1) * d))));
		v_count(i + 1) = sum(sum((v >= (i * d) & v < ((i + 1) * d))));
	endfor

	hsv = [h_count, s_count, v_count]; % se obtine lista finala
endfunction