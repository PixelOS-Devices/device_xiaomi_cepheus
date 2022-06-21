/*
 * Copyright (C) 2021-2022 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_variant.h>

#include "vendor_init.h"

static const variant_info_t cepheus_info = {
    .hwc_value = "",
    .sku_value = "",

    .brand = "Xiaomi",
    .device = "cepheus",
    .marketname = "",
    .model = "MI 9",
    .build_fingerprint = "Xiaomi/cepheus/cepheus:11/RKQ1.200826.002/V12.5.1.0.RFAMIXM:user/release-keys",

    .nfc = true,
};

static const std::vector<variant_info_t> variants = {
    cepheus_info,
};

void vendor_load_properties() {
    set_dalvik_heap();
    search_variant(variants);
}
