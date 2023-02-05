%% nfdata to fmt format data
% nfdata_raw = importdata("D:\Documents\WeChat Files\wxid_1w78oqtxfh5j22\FileStorage\File\2022-12\NFData20210727010.txt");

% 截取
nfdata = nfdata_raw.data(1:480000,:);

% create timeseries
time_ms = uint32(nfdata(:,2));

% get true time stamp
cyc_point = find(time_ms < 5);  % find cycle timetick
inc_time = zeros(size(time_ms), 'like', time_ms);
for i=1:length(cyc_point)
    inc_time(cyc_point(i):end) = inc_time(cyc_point(i):end) + 300000;
end
time_ms = time_ms + inc_time;

time_stamp = double(time_ms - time_ms(1)) * 0.001; % milli second to second

% gyro & acc
IMU.timestamp   = timeseries(time_ms, time_stamp);
IMU.gyr_x       = timeseries(single(nfdata(:,3) * pi/180), time_stamp);
IMU.gyr_y       = timeseries(single(nfdata(:,4) * pi/180), time_stamp);
IMU.gyr_z       = timeseries(single(nfdata(:,5) * pi/180), time_stamp);
IMU.acc_x       = timeseries(single(nfdata(:,6) * INS_CONST.g), time_stamp);
IMU.acc_y       = timeseries(single(nfdata(:,7) * INS_CONST.g), time_stamp);
IMU.acc_z       = timeseries(single(nfdata(:,8) * INS_CONST.g), time_stamp);

% SBG reference
INS_Out.timestamp= timeseries(time_ms, time_stamp);
INS_Out.phi      = timeseries(single(deg2rad(nfdata(:,28))), time_stamp);
INS_Out.theta    = timeseries(single(deg2rad(nfdata(:,29))), time_stamp);
INS_Out.psi      = timeseries(single(deg2rad(nfdata(:,30))), time_stamp);

% aerial
Aerial.timestamp = timeseries(time_ms, time_stamp);
Aerial.yaw_ref   = timeseries(single(deg2rad(nfdata(:,24))), time_stamp);


% out_file = strcat(Path, ['/', BusName, '.mat']);
% save(out_file, BusName);
% fprintf("Save to path:%s\n", out_file);

% gps
gps_valid = find(nfdata(:,9) == 1);
gps_data = nfdata(gps_valid, :);
gps_time_ms = time_ms(gps_valid);
gps_time_stamp = double(gps_time_ms - time_ms(1)) * 0.001; % milli second to second


GPS_uBlox.timestamp   = timeseries(gps_time_ms, gps_time_stamp);
GPS_uBlox.numSV       = timeseries(uint8(gps_data(:,11)), gps_time_stamp);
GPS_uBlox.lat         = timeseries(int32(gps_data(:,12) * 1e7*180/pi), gps_time_stamp);
GPS_uBlox.lon         = timeseries(int32(gps_data(:,13) * 1e7*180/pi), gps_time_stamp);
GPS_uBlox.height      = timeseries(int32(gps_data(:,14) * 1e3), gps_time_stamp);
GPS_uBlox.velN        = timeseries(int32(gps_data(:,15) * 1e3), gps_time_stamp);
GPS_uBlox.velE        = timeseries(int32(gps_data(:,16) * 1e3), gps_time_stamp);
GPS_uBlox.velD        = timeseries(int32(gps_data(:,17) * 1e3), gps_time_stamp);
% TODO: fix
GPS_uBlox.fixType     = timeseries(uint8(ones(size(gps_data(:,1))) * 3), gps_time_stamp);
GPS_uBlox.hAcc        = timeseries(uint32(gps_data(:,22) * 1e3 / 4), gps_time_stamp);
GPS_uBlox.vAcc        = timeseries(uint32(gps_data(:,23) * 1e3 / 4), gps_time_stamp);
GPS_uBlox.sAcc        = timeseries(uint32(ones(size(gps_data(:,1))) * 180), gps_time_stamp);


function [array_rad] = deg2rad(array_deg)
    array_rad = (array_deg - (array_deg > 180) * 360) * pi/180;
end
