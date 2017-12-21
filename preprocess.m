function [X, t] = preprocess(path_to_dataset, histogram, count_bins)
	% caile pentru directoarele /cats si /not_cats
	path_to_cats = strcat(path_to_dataset, 'cats/');
	path_to_not_cats = strcat(path_to_dataset, 'not_cats/');

	% stocam numele imaginilor cu psici si cele fara pisici
	cats = getImgNames(path_to_cats);
	not_cats = getImgNames(path_to_not_cats);

	% aflam nr de poze cu pisici si nr de poze fara pisici
	[nr_img_cats length_img_cats] = size(cats);
	[nr_img_not_cats length_img_not_cats] = size(not_cats);

	n = nr_img_cats + nr_img_not_cats; % nr total de poze
	m = 3 * count_bins; % nr de linii ale matricei X inainte de adaugarea liniei de 1

	% initializam matricile X si t
	X = zeros(n, m);
	t = zeros(n, 1);

	% Construim matricile X si t
	if(strcmp(histogram, "RGB")) % cazul RGB
		for i = 1 : nr_img_cats
			img = cats(i, 1:length_img_cats); % numele imaginii de verificat
			in = strcat(path_to_cats, img); % calea catre poza
			row = rgbHistogram(in, count_bins); % histograma RGB
			X(i, :) = row;
			t(i, 1) = 1; % label-ul ptr poza cu pisica
		endfor

		for i = 1 : nr_img_not_cats
			img = not_cats(i, 1:length_img_not_cats); % numele imaginii de verificat
			in = strcat(path_to_not_cats, img); % calea catre poza
			row = rgbHistogram(in, count_bins); % histograma RGB
			X(i + nr_img_cats, :) = row;
			t(i + nr_img_cats, 1) = -1; % label-ul ptr poza fara pisica
		endfor

		X = [X ones(n,1)];
	elseif(strcmp(histogram, "HSV")) % cazul HSV
		for i = 1 : nr_img_cats
			img = cats(i, 1:length_img_cats); % numele imaginii de verificat
			in = strcat(path_to_cats, img); % calea catre poza
			row = hsvHistogram(in, count_bins); % histograma HSV
			X(i, :) = row;
			t(i, 1) = 1; % label-ul ptr poza cu pisica
		endfor

		for i = 1 : nr_img_not_cats
			img = not_cats(i, 1:length_img_not_cats); % numele imaginii de verificat
			in = strcat(path_to_not_cats, img); % calea catre poza
			row = hsvHistogram(in, count_bins); % histograma HSV
			X(i + nr_img_cats, :) = row;
			t(i + nr_img_cats, 1) = -1; % label-ul ptr poza fara pisica
		endfor

		X = [X ones(n,1)]; % adaugam linia de 1 in matricea X
	endif
end