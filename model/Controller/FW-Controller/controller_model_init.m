model_version = 'v1.0.0';
model_name = 'FW Controller';

%% load configuration
load('control_default_config.mat');

%% Constant Variable
CONTROL_CONST.dt = 0.002;   % model execution period
CONTROL_CONST.g  = single(9.80665);

%% Exported Value
CONTROL_EXPORT_VALUE.period = uint32(CONTROL_CONST.dt*1e3);
CONTROL_EXPORT_VALUE.model_info = int8([model_name, ' ', model_version, 0]); % 0 for end of string
% Export to firmware
CONTROL_EXPORT = Simulink.Parameter(CONTROL_EXPORT_VALUE);
CONTROL_EXPORT.CoderInfo.StorageClass = 'ExportedGlobal';

% Airframe id
AIRFRAME = 1;

%% Paramaters
CONTROL_PARAM_VALUE.ROLL_P  = single(7);
CONTROL_PARAM_VALUE.PITCH_P = single(7);
CONTROL_PARAM_VALUE.FW_ROLL_EFFC    = single(1.0);
CONTROL_PARAM_VALUE.FW_PITCH_EFFC   = single(1.0);
CONTROL_PARAM_VALUE.FW_YAW_EFFC     = single(1.0);

CONTROL_PARAM_VALUE.ROLL_RATE_P     = single(0.1);
CONTROL_PARAM_VALUE.PITCH_RATE_P    = single(0.2);
CONTROL_PARAM_VALUE.YAW_RATE_P      = single(0.15);
CONTROL_PARAM_VALUE.ROLL_RATE_I     = single(0.1);
CONTROL_PARAM_VALUE.PITCH_RATE_I    = single(0.1);
CONTROL_PARAM_VALUE.YAW_RATE_I      = single(0.2);
CONTROL_PARAM_VALUE.RATE_I_MIN      = single(-0.1);
CONTROL_PARAM_VALUE.RATE_I_MAX      = single(0.1);

CONTROL_PARAM_VALUE.FW_AIRSPD_MIN   = single(10.0); % Minimum Airspeed (CAS)
CONTROL_PARAM_VALUE.FW_AIRSPD_MAX   = single(20.0); % Maximum Airspeed (CAS)
CONTROL_PARAM_VALUE.FW_AIRSPD_TRIM  = single(15.0); % Trim (Cruise) Airspeed
CONTROL_PARAM_VALUE.FW_AIRSPD_STALL = single(7.0);  % Stall Airspeed (CAS)
CONTROL_PARAM_VALUE.FW_ARSP_MODE    = int32(0);     % Airspeed mode: 0 Use airspeed in controller
CONTROL_PARAM_VALUE.FW_ARSP_SCALE_EN= int32(1);     % Enable airspeed scaling
CONTROL_PARAM_VALUE.FW_T_SPD_STD    = single(0.2);  % Airspeed measurement standard deviation for airspeed filter
CONTROL_PARAM_VALUE.FW_T_SPD_PRC_STD = single(0.2); % Process noise standard deviation for the airspeed rate in the airspeed filter
CONTROL_PARAM_VALUE.FW_T_TAS_TC     = single(5.0);  % True airspeed error time constant
CONTROL_PARAM_VALUE.FW_T_I_GAIN_PIT = single(0.1);  % Integrator gain pitch
CONTROL_PARAM_VALUE.FW_T_I_GAIN_THR = single(0.05); % Integrator gain throttle
CONTROL_PARAM_VALUE.FW_T_THR_DAMP   = single(0.1);  % Throttle damping factor
CONTROL_PARAM_VALUE.FW_T_SPDWEIGHT  = single(1.0);  % Speed <--> Altitude priority
CONTROL_PARAM_VALUE.FW_T_CLMB_MAX   = single(5.0);  % Maximum climb rate:This is the maximum climb rate that the aircraft can achieve with the throttle set to THR_MAX and the airspeed set to the trim value. 
CONTROL_PARAM_VALUE.FW_T_SINK_MIN   = single(2.0);  % Minimum descent rate
CONTROL_PARAM_VALUE.FW_T_SINK_MAX   = single(5.0);  % Maximum descent rate
CONTROL_PARAM_VALUE.FW_T_CLMB_R_SP  = single(3.0);  % Default target climbrate
CONTROL_PARAM_VALUE.FW_T_SINK_R_SP  = single(2.0);  % Default target sinkrate
CONTROL_PARAM_VALUE.FW_P_LIM_MAX    = single(deg2rad(30.0)); % Maximum pitch angle
CONTROL_PARAM_VALUE.FW_P_LIM_MIN    = single(deg2rad(-30.0));% Minimum pitch angle
CONTROL_PARAM_VALUE.FW_R_LIM        = single(deg2rad(50.0)); % Maximum roll angle
CONTROL_PARAM_VALUE.FW_T_VERT_ACC   = single(7.0);  % Maximum vertical acceleration
CONTROL_PARAM_VALUE.FW_PSP_OFF      = single(0.0);  % Pitch setpoint offset (pitch at level flight)

%% Throttle
CONTROL_PARAM_VALUE.FW_THR_MAX      = single(1.0);  % Throttle limit max
CONTROL_PARAM_VALUE.FW_THR_MIN      = single(0.0);  % Throttle limit min
CONTROL_PARAM_VALUE.FW_THR_TRIM     = single(0.6);  % Trim throttle

%% Ctrl Param
CONTROL_PARAM_VALUE.FW_T_SEB_R_FF   = single(1.0);  % Specific total energy balance rate feedforward gain
CONTROL_PARAM_VALUE.FW_T_I_GAIN_PIT = single(0.1);  % Integrator gain pitch
CONTROL_PARAM_VALUE.FW_T_PTCH_DAMP  = single(0.1);  % Pitch damping factor
CONTROL_PARAM_VALUE.FW_T_I_GAIN_THR = single(0.05); % Integrator gain throttle
CONTROL_PARAM_VALUE.FW_T_THR_DAMP   = single(0.1);  % Throttle damping factor

CONTROL_PARAM_VALUE.FW_RR_FF        = single(0.5);  % Roll rate feed forward
CONTROL_PARAM_VALUE.FW_PR_FF        = single(0.5);  % Pitch rate feed forward
CONTROL_PARAM_VALUE.FW_YR_FF        = single(0.3);  % Yaw rate feed forward

% Export to firmware
CONTROL_PARAM = Simulink.Parameter(CONTROL_PARAM_VALUE);
CONTROL_PARAM.CoderInfo.StorageClass = 'ExportedGlobal';