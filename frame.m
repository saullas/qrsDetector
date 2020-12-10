function frame( record )
  % Summary of this function and detailed explanation goes here
  
  fileName = sprintf('1.0.0/%sm.mat', record);
  
  t = cputime();
  
  m = 5;
  sumWindow = 10;
  alpha = 0.05;
  gamma = 0.15;
  step = 180;
  idx = detector(fileName, m, sumWindow, alpha, gamma, step);
  
  fprintf('Running time: %f\n', cputime() - t);
  
  asciName = sprintf('%s.asc',record);
  fid = fopen(asciName, 'wt');
  
  for i=1:size(idx, 2)
      fprintf(fid,'0:00:00.00 %d N 0 0 0\n', idx(1, i) );
  end
  
  fclose(fid);

  % Now convert the .asc text output to binary WFDB format:
  % wrann -r record -a qrs <record.asc
  % And evaluate against reference annotations (atr) using bxb:
  % bxb -r record -a atr qrs
end

