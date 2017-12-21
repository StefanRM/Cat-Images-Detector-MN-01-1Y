function [proc] = evaluate(path_to_testset, w, histogram, count_bins)
	% caile pentru directoarele /cats si /not_cats
	path_to_cats = strcat(path_to_testset, 'cats/');
	path_to_not_cats = strcat(path_to_testset, 'not_cats/');

	% stocam numele imaginilor cu psici si cele fara pisici
	cats = getImgNames(path_to_cats);
	not_cats = getImgNames(path_to_not_cats);

	% aflam nr de poze cu pisici si nr de poze fara pisici
	[nr_img_cats length_img_cats] = size(cats);
	[nr_img_not_cats length_img_not_cats] = size(not_cats);

	nr_correct = 0; % initializam nr de poze clasificate corect

	if(strcmp(histogram, "RGB")) % cazul RGB
		for i = 1 : nr_img_cats
			img = cats(i, 1:length_img_cats); % numele imaginii de verificat
			in = strcat(path_to_cats, img); % calea catre poza
			x = rgbHistogram(in, count_bins); % histograma RGB
			x = x';
			x = [x; 1]; % adaugam o linie de 1
			y = w' * x; % calculam y dupa formula

			% clasificarea pozei
			if (y >= 0)
				y = 1;
			else
				y = -1;
			endif

			% verificam daca poza a fost clasificata corect
			if (y == 1)
				nr_correct = nr_correct + 1;
			endif
		endfor

		for i = 1 : nr_img_not_cats
			img = not_cats(i, 1:length_img_not_cats); % numele imaginii de verificat
			in = strcat(path_to_not_cats, img); % calea catre poza
			x = rgbHistogram(in, count_bins); % histograma RGB
			x = x';
			x = [x; 1]; % adaugam o linie de 1
			y = w' * x; % calculam y dupa formula

			% clasificarea pozei
			if (y >= 0)
				y = 1;
			else
				y = -1;
			endif

			% verificam daca poza a fost clasificata corect
			if (y == -1)
				nr_correct = nr_correct + 1;
			endif
		endfor
	elseif(strcmp(histogram, "HSV")) % cazul HSV
		for i = 1 : nr_img_cats
			img = cats(i, 1:length_img_cats); % numele imaginii de verificat
			in = strcat(path_to_cats, img); % calea catre poza
			x = hsvHistogram(in, count_bins); % histograma HSV
			x = x';
			x = [x; 1]; % adaugam o linie de 1
			y = w' * x; % calculam y dupa formula

			% clasificarea pozei
			if (y >= 0)
				y = 1;
			else
				y = -1;
			endif

			% verificam daca poza a fost clasificata corect
			if (y == 1)
				nr_correct = nr_correct + 1;
			endif
		endfor

		for i = 1 : nr_img_not_cats
			img = not_cats(i, 1:length_img_not_cats); % numele imaginii de verificat
			in = strcat(path_to_not_cats, img); % calea catre poza
			x = hsvHistogram(in, count_bins); % histograma HSV
			x = x';
			x = [x; 1]; % adaugam o linie de 1
			y = w' * x; % calculam y dupa formula

			% clasificarea pozei
			if (y >= 0)
				y = 1;
			else
				y = -1;
			endif

			% verificam daca poza a fost clasificata corect
			if (y == -1)
				nr_correct = nr_correct + 1;
			endif
		endfor
	endif

	% calculam procentajul pozelor clasificate corect
	proc = (nr_correct * 100) / (nr_img_cats + nr_img_not_cats);
end