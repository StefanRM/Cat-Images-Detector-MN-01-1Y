function [rgb] = rgbHistogram(path_to_image, count_bins)
	% listele in functie de culori
	r_count = zeros(1, count_bins);
	g_count = zeros(1, count_bins);
	b_count = zeros(1, count_bins);

	% citirea celor 3 matrici in functie de culori
	ColorMatrix = imread(path_to_image);
	r = ColorMatrix(:, :, 1);
	g = ColorMatrix(:, :, 2);
	b = ColorMatrix(:, :, 3);

	d = 256 / count_bins; % lungime intervale

	% se formeaza 3 liste pentru cele count_bins intervale
	for i = 0 : (count_bins - 1)
		r_count(i + 1) = sum(sum((r >= (i * d) & r < ((i + 1) * d))));
		g_count(i + 1) = sum(sum((g >= (i * d) & g < ((i + 1) * d))));
		b_count(i + 1) = sum(sum((b >= (i * d) & b < ((i + 1) * d))));
	endfor

	rgb = [r_count, g_count, b_count]; % se obtine lista finala
endfunction