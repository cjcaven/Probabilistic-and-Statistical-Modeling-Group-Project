%this script calculates the avg result for a cluster, you need to
%provide the path to the cluster mask and the image with the coreelation
%coefficients averaged over participans

cluster_file= 'C:\shared_data\RSA_results\type\cluster5_mask.nii'; %specify your binary cluster mask
cluster_mask=spm_read_vols(spm_vol(cluster_file));


image='C:\shared_data\RSA_results\type\avg_correlation_2.nii'; %specify your correlaiton map, averaged over participants
hdr=spm_vol(image);
vol= spm_read_vols(hdr, cluster_mask);

values=cluster_mask>0; %get the indicies of the mask voxels


cluster_mean=mean(vol(values),'double','omitnan'); %calculate mean correlation

cluster_sd=std(vol(values), 1,'all'); %calculate standard deviation






