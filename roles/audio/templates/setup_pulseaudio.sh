#/bin/bash
pulseaudio -k
HEADSET_MIC="Mpow_HC_20170817-00.mono-fallback"
HEADSET_SPKR="Mpow_HC_20170817-00.analog-stereo"

#TRX_SPKR="USB_PnP_Sound_Device-00.mono-fallback"
TRX_SPKR="GeneralPlus_USB_Audio_Device-00.mono-fallback"  #Yaesu direct soundcard
TRX_MIC="USB_PnP_Sound_Device-00.analog-stereo"

HEADSET_MIC_NR=$(pactl list short sources| grep $HEADSET_MIC | sed -e "s/[[:space:]]\+/ /g" | cut -d ' ' -f1)
HEADSET_SPKR_NR=$(pactl list short sinks| grep $HEADSET_SPKR | sed -e "s/[[:space:]]\+/ /g" | cut -d ' ' -f1)

TRX_SPKR_NR=$(pactl list short sources| grep $TRX_SPKR | sed -e "s/[[:space:]]\+/ /g" | cut -d ' ' -f1)
TRX_MIC_NR=$(pactl list short sinks| grep $TRX_MIC | sed -e "s/[[:space:]]\+/ /g" | cut -d ' ' -f1)
#pactl list short sinks

echo "HEADSET_MIC: $HEADSET_MIC ==> $HEADSET_MIC_NR"
echo "HEADSET_SPKR: $HEADSET_SPKR ==> $HEADSET_SPKR_NR"
echo "TRX_SPKR: $TRX_SPKR ==> $TRX_SPKR_NR"
echo "TRX_MIC: $TRX_MIC ==> $TRX_MIC_NR"

# create loopback TRX SPKR TO HEADSET SPKR
pactl load-module module-null-sink sink_name="TRX_TO_HEADSET"
pacmd update-sink-proplist TRX_TO_HEADSET device.description="\"TRX TO HEADSET\""
pactl load-module module-loopback source=$TRX_SPKR_NR sink=$HEADSET_SPKR_NR


# create loopback TRX SPKR TO HEADSET SPKR
pactl load-module module-null-sink sink_name="HEADSET_TO_TRX"
pacmd update-sink-proplist HEADSET_TO_TRX device.description="\"HEADSET TO TRX\""
pactl load-module module-loopback source=$HEADSET_MIC_NR sink=$TRX_MIC_NR

# To use the equalizer
pactl load-module module-equalizer-sink
pactl load-module module-dbus-protocol