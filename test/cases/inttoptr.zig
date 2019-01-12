const builtin = @import("builtin");
const std = @import("std");
const assertOrPanic = std.debug.assertOrPanic;
const assert = std.debug.assert;

test "casting random address to function pointer" {
    randomAddressToFunction();
    comptime randomAddressToFunction();
}

fn randomAddressToFunction() void {
    var addr: usize = 0xdeadbeef;
    var ptr = @intToPtr(fn () void, addr);
}

test "mutate through ptr initialized with constant intToPtr value" {
    forceCompilerAnalyzeBranchHardCodedPtrDereference(false);
}

fn forceCompilerAnalyzeBranchHardCodedPtrDereference(x: bool) void {
    const hardCodedP = @intToPtr(*volatile u8, 0xdeadbeef);
    if (x) {
        hardCodedP.* = hardCodedP.* | 10;
    } else {
        return;
    }
}

const Enum_packed_u2 = packed enum(u2) {
    VAL_0 = 0,
    VAL_1 = 1,
    VAL_2 = 2,
    VAL_3 = 3,
};
const Enum_packed_u1 = packed enum(u1) {
    VAL_0 = 0,
    VAL_1 = 1,
};
const Struct_packed_u32 = packed struct(u32) {
    _zeroes_31_4: u27,
    _zeroes_3: u1,
    u2_field: Enum_packed_u2,
    u1_field_1: Enum_packed_u1,
    u1_field_2: Enum_packed_u1,
};
const Enum_packed_u32 = packed enum(u32) {
    One,
    Two,
    Three,
};

test "packed aggregate hardcoded address alignment" {
// Alignment of packed aggregate is minimum of alignment of packed type and address alignment
//const packed_u32_ptr_align1 = @intToPtr(*volatile Struct_packed_u32, 0x01);
//const packed_u32_ptr_align2 = @intToPtr(*volatile Struct_packed_u32, 0x02);
//const packed_u32_ptr_align4_1 = @intToPtr(*volatile Struct_packed_u32, 0x04);
//const packed_u32_ptr_align4_2 = @intToPtr(*volatile Struct_packed_u32, 0x08);
//const packed_u32_ptr_align4_3 = @intToPtr(*volatile Struct_packed_u32, 0x10);
//const packed_u32_ptr_align4_4 = @intToPtr(*volatile Struct_packed_u32, 0x00);
//assert(@alignOf(@typeOf(packed_u32_ptr_align1.*)) == 1);
//assert(@alignOf(@typeOf(packed_u32_ptr_align2.*)) == 2);
//assert(@alignOf(@typeOf(packed_u32_ptr_align4_1.*)) == 4);
//assert(@alignOf(@typeOf(packed_u32_ptr_align4_2.*)) == 4);
//assert(@alignOf(@typeOf(packed_u32_ptr_align4_3.*)) == 4);
//assert(@alignOf(@typeOf(packed_u32_ptr_align4_4.*)) == 4);

//const packedE_u32_ptr_align1 = @intToPtr(*Enum_packed_u32, 0x01);
//const packedE_u32_ptr_align2 = @intToPtr(*Enum_packed_u32, 0x02);
//const packedE_u32_ptr_align4_1 = @intToPtr(*Enum_packed_u32, 0x04);
//const packedE_u32_ptr_align4_2 = @intToPtr(*Enum_packed_u32, 0x08);
//const packedE_u32_ptr_align4_3 = @intToPtr(*Enum_packed_u32, 0x10);
//const packedE_u32_ptr_align4_4 = @intToPtr(*Enum_packed_u32, 0x00);
//assert(@alignOf(packedE_u32_ptr_align1) == 1);
//assert(@alignOf(packedE_u32_ptr_align2) == 2);
//assert(@alignOf(packedE_u32_ptr_align4_1) == 4);
//assert(@alignOf(packedE_u32_ptr_align4_2) == 4);
//assert(@alignOf(packedE_u32_ptr_align4_3) == 4);
//assert(@alignOf(packedE_u32_ptr_align4_4) == 4);
//
//const packedE_u2_ptr_align1_1 = @intToPtr(*Enum_packed_u2, 0x01);
//const packedE_u2_ptr_align1_2 = @intToPtr(*Enum_packed_u2, 0x02);
//const packedE_u2_ptr_align1_3 = @intToPtr(*Enum_packed_u2, 0x04);
//const packedE_u2_ptr_align1_4 = @intToPtr(*Enum_packed_u2, 0x08);
//const packedE_u2_ptr_align1_5 = @intToPtr(*Enum_packed_u2, 0x10);
//const packedE_u2_ptr_align1_6 = @intToPtr(*Enum_packed_u2, 0x00);
//assert(@alignOf(packedE_u2_ptr_align1_1) == 1);
//assert(@alignOf(packedE_u2_ptr_align1_2) == 1);
//assert(@alignOf(packedE_u2_ptr_align1_3) == 1);
//assert(@alignOf(packedE_u2_ptr_align1_4) == 1);
//assert(@alignOf(packedE_u2_ptr_align1_5) == 1);
//assert(@alignOf(packedE_u2_ptr_align1_6) == 1);

// Alignment of packed aggregate can be overridden
const packed_u32_ptr_align1_override = @intToPtr(*volatile  align(1) Struct_packed_u32, 0x00);
const packed_u32_ptr_align2_override = @intToPtr(*volatile  align(2) Struct_packed_u32, 0x01);
const packed_u32_ptr_align4_override = @intToPtr(*volatile  align(4) Struct_packed_u32, 0x02);
const packed_u32_ptr_align8_override = @intToPtr(*volatile  align(8) Struct_packed_u32, 0x08);
const packed_u32_ptr_align16_override = @intToPtr(*volatile  align(16) Struct_packed_u32, 0x01);
const packed_u32_ptr_align16_0_override = @intToPtr(*volatile  align(16) Struct_packed_u32, 0x01);
assert(@alignOf(@typeOf(packed_u32_ptr_align1_override.*)) == 1);
assert(@alignOf(@typeOf(packed_u32_ptr_align2_override.*)) == 2);
assert(@alignOf(@typeOf(packed_u32_ptr_align4_override.*)) == 4);
assert(@alignOf(@typeOf(packed_u32_ptr_align8_override.*)) == 8);
assert(@alignOf(@typeOf(packed_u32_ptr_align16_override.*)) == 16);
assert(@alignOf(@typeOf(packed_u32_ptr_align16_override.*)) == 16);
}

