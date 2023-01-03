#! /vendor/bin/sh

# Copyright (c) 2012-2013, 2016-2019, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.board.platform`

case "$target" in
    "msmnile")
    # Enable bus-dcvs
    for device in /sys/devices/platform/soc
    do
        for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 40 > $cpubw/polling_interval
            echo "2288 4577 7110 9155 12298 14236 15258" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 50 > $cpubw/bw_hwmon/io_percent
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 10 > $cpubw/bw_hwmon/hyst_length
            echo 30 > $cpubw/bw_hwmon/down_thres
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
            echo 14236 > $cpubw/max_freq
        done

        for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
        do
            echo "bw_hwmon" > $llccbw/governor
            echo 40 > $llccbw/polling_interval
            echo "1720 2929 3879 5931 6881 7980" > $llccbw/bw_hwmon/mbps_zones
            echo 4 > $llccbw/bw_hwmon/sample_ms
            echo 80 > $llccbw/bw_hwmon/io_percent
            echo 20 > $llccbw/bw_hwmon/hist_memory
            echo 10 > $llccbw/bw_hwmon/hyst_length
            echo 30 > $llccbw/bw_hwmon/down_thres
            echo 0 > $llccbw/bw_hwmon/guard_band_mbps
            echo 250 > $llccbw/bw_hwmon/up_scale
            echo 1600 > $llccbw/bw_hwmon/idle_mbps
            echo 6881 > $llccbw/max_freq
        done

        for npubw in $device/*npu-npu-ddr-bw/devfreq/*npu-npu-ddr-bw
        do
            echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
            echo "bw_hwmon" > $npubw/governor
            echo 40 > $npubw/polling_interval
            echo "1720 2929 3879 5931 6881 7980" > $npubw/bw_hwmon/mbps_zones
            echo 4 > $npubw/bw_hwmon/sample_ms
            echo 80 > $npubw/bw_hwmon/io_percent
            echo 20 > $npubw/bw_hwmon/hist_memory
            echo 6  > $npubw/bw_hwmon/hyst_length
            echo 30 > $npubw/bw_hwmon/down_thres
            echo 0 > $npubw/bw_hwmon/guard_band_mbps
            echo 250 > $npubw/bw_hwmon/up_scale
            echo 0 > $npubw/bw_hwmon/idle_mbps
            echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
        done

        # Enable mem_latency governor for L3, LLCC, and DDR scaling
        for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done

        # Enable userspace governor for L3 cdsp nodes
        for l3cdsp in $device/*cdsp-cdsp-l3-lat/devfreq/*cdsp-cdsp-l3-lat
        do
            echo "cdspl3" > $l3cdsp/governor
        done

        # Enable compute governor for gold latfloor
        for latfloor in $device/*cpu-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
        do
            echo "compute" > $latfloor/governor
            echo 10 > $latfloor/polling_interval
        done

        # Gold L3 ratio ceil
        for l3gold in $device/*cpu4-cpu-l3-lat/devfreq/*cpu4-cpu-l3-lat
        do
            echo 4000 > $l3gold/mem_latency/ratio_ceil
        done

        # Prime L3 ratio ceil
        for l3prime in $device/*cpu7-cpu-l3-lat/devfreq/*cpu7-cpu-l3-lat
        do
            echo 20000 > $l3prime/mem_latency/ratio_ceil
        done
    done
    ;;
esac

setprop vendor.post_boot.parsed 1