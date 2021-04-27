/*
Copyright 2020 Cole Smith <cole@boadsource.xyz>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H
#include "split_util.h"

#define _x_ KC_NO

// Symbol mod taps
#define CTL_LPRN MT(MOD_LCTL, KC_F23)
#define CMD_LPRN LCTL_T(KC_LANG6)

// Multi-char inputs
#define OUT_COM "//"
#define OUT_EQU "=="
#define OUT_NEQ "!="
#define OUT_RNG ".."
#define OUT_ECM ";;"
#define OUT_LAR "<-"
#define OUT_RAR "->"
#define OUT_DEC "--"
#define OUT_INC "++"
#define OUT_AND "&&"
#define OUT_OR "||"
#define OUT_SCP "::"
#define OUT_FAR "=>"
#define OUT_EQG ">="
#define OUT_EQL "<="
#define OUT_PAR "|>"
#define OUT_WAL ":="

enum custom_keycodes {
    MT_LCTL = SAFE_RANGE,
    CC_COM,  // Comment
    CC_EQU,  // Equality
    CC_NEQ,  // Not equals
    CC_RNG,  // Range
    CC_ECM,  // Emacs comment
    CC_LAR,  // Left arrow
    CC_RAR,  // Right arrow
    CC_DEC,  // Decrement
    CC_INC,  // Incrememnt
    CC_AND,  // And
    CC_OR,   // Or
    CC_SCP,  // Scope
    CC_FAR,  // Fat arrow right
    CC_FOR,  // For
    CC_FRR,  // Reverse for
    CC_EQG,  // Equal or greater
    CC_EQL,  // Equal or less
    CC_PAR,  // Pipe arrow right
    CC_WAL,  // Walrus
};

#define HOME_LPRN LCTL_T(MT_LCTL)

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case HOME_LPRN:
            if (record->tap.count > 0) {
                if (record->event.pressed) {
                    tap_code16(S(KC_9));  // (
                }
                return false;
            }
            break;
        case CC_COM:
            if (record->event.pressed) {
                SEND_STRING(OUT_COM);
            }

            break;
        case CC_EQU:
            if (record->event.pressed) {
                SEND_STRING(OUT_EQU);
            }
            break;
        case CC_NEQ:
            if (record->event.pressed) {
                SEND_STRING(OUT_NEQ);
            }
            break;
        case CC_RNG:
            if (record->event.pressed) {
                SEND_STRING(OUT_RNG);
            }
            break;
        case CC_ECM:
            if (record->event.pressed) {
                SEND_STRING(OUT_ECM);
            }
            break;
        case CC_LAR:
            if (record->event.pressed) {
                SEND_STRING(OUT_LAR);
            }
            break;
        case CC_RAR:
            if (record->event.pressed) {
                SEND_STRING(OUT_RAR);
            }
            break;
        case CC_DEC:
            if (record->event.pressed) {
                SEND_STRING(OUT_DEC);
            }
            break;
        case CC_INC:
            if (record->event.pressed) {
                SEND_STRING(OUT_INC);
            }
            break;
        case CC_AND:
            if (record->event.pressed) {
                SEND_STRING(OUT_AND);
            }
            break;
        case CC_OR:
            if (record->event.pressed) {
                SEND_STRING(OUT_OR);
            }
            break;
        case CC_SCP:
            if (record->event.pressed) {
                SEND_STRING(OUT_SCP);
            }
            break;
        case CC_FAR:
            if (record->event.pressed) {
                SEND_STRING(OUT_FAR);
            }
            break;
        case CC_FOR:
            if (record->event.pressed) {
                SEND_STRING("for	");
            }
            break;
        case CC_FRR:
            if (record->event.pressed) {
                SEND_STRING("forr	");
            }
            break;
        case CC_EQG:
            if (record->event.pressed) {
                SEND_STRING(OUT_EQG);
            }
            break;
        case CC_EQL:
            if (record->event.pressed) {
                SEND_STRING(OUT_EQL);
            }
            break;
        case CC_PAR:
            if (record->event.pressed) {
                SEND_STRING(OUT_PAR);
            }
            break;
        case CC_WAL:
            if (record->event.pressed) {
                SEND_STRING(OUT_WAL);
            }
    }
    return true;
};

// Combos
enum combos {
    UK_Q,
    KJ_Z,
    MY_COMBO_GM,
    MY_COMBO_MB,
};

const uint16_t PROGMEM uk_combo[] = {KC_U, KC_K, COMBO_END};
const uint16_t PROGMEM kj_combo[] = {KC_K, KC_J, COMBO_END};
const uint16_t PROGMEM gm_combo[] = {KC_G, KC_M, COMBO_END};
const uint16_t PROGMEM mb_combo[] = {KC_M, KC_B, COMBO_END};

combo_t key_combos[COMBO_COUNT] = {
    [UK_Q]        = COMBO(uk_combo, KC_Q),   //
    [KJ_Z]        = COMBO(kj_combo, KC_Z),   //
    [MY_COMBO_GM] = COMBO_ACTION(gm_combo),  //
    [MY_COMBO_MB] = COMBO_ACTION(mb_combo),  //
};

void process_combo_event(uint16_t combo_index, bool pressed) {
    switch (combo_index) {
        case MY_COMBO_GM:
            if (pressed) {
                SEND_STRING("gl");
            }
            break;
        case MY_COMBO_MB:
            if (pressed) {
                SEND_STRING("bl");
            }
            break;
    }
}

enum layers { _BASE, _SYM1, _SYM2, _FN, _NAV, _OS, _GAME };

// TODO: This is not working.
enum {
    TD_X_TRNS = 0,
};
qk_tap_dance_action_t tap_dance_actions[] = {
    [TD_X_TRNS] = ACTION_TAP_DANCE_DOUBLE(_x_, TG(_GAME)),
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT_split_3x5_3(S(KC_1), KC_G, KC_M, KC_B, KC_ENT, KC_QUOTE, KC_U, KC_K, KC_J, S(KC_SLSH),                                                                    //
                                 LT(_NAV, KC_R), LGUI_T(KC_S), LCTL_T(KC_N), LALT_T(KC_T), RALT_T(KC_F), RALT_T(KC_Y), LALT_T(KC_H), LCTL_T(KC_A), LGUI_T(KC_O), LT(5, KC_I),  //
                                 KC_X, KC_C, LT(_OS, KC_L), KC_D, KC_W, KC_V, KC_P, KC_COMM, KC_DOT, KC_UNDS,                                                                  //
                                 KC_BSPC, LT(_SYM1, KC_E), LT(_FN, KC_ESC), LT(_SYM2, KC_TAB), LSFT_T(KC_SPC), KC_DEL),

    [_SYM1] = LAYOUT_split_3x5_3(DF(_GAME), _x_, KC_EQL, S(KC_EQL), CC_EQL, CC_EQG, S(KC_8), KC_SLSH, S(KC_SCLN), _x_,                                        //
                                 KC_7, LGUI_T(KC_5), LCTL_T(KC_0), LALT_T(KC_4), RALT_T(KC_6), RALT_T(KC_9), LALT_T(KC_1), LCTL_T(KC_2), LGUI_T(KC_3), KC_8,  //
                                 _x_, _x_, KC_SCLN, S(KC_7), S(KC_COMM), S(KC_DOT), _x_, S(KC_BSLS), CC_RNG, KC_SCLN,                                         //
                                 _x_, _x_, _x_, S(KC_TAB), KC_MINS, KC_DEL),

    [_SYM2] = LAYOUT_split_3x5_3(_x_, KC_BSLS, S(KC_6), S(KC_4), _x_, _x_, S(KC_5), KC_GRV, S(KC_GRV), _x_,                    //
                                 CC_WAL, KC_LBRC, S(KC_9), S(KC_LBRC), CC_RAR, CC_LAR, S(KC_RBRC), S(KC_0), KC_RBRC, S(KC_3),  //
                                 _x_, _x_, S(KC_SCLN), CC_FAR, _x_, _x_, S(KC_2), CC_SCP, CC_PAR, _x_,                         //
                                 KC_BSPC, CC_NEQ, _x_, _x_, CC_RNG, _x_),

    [_FN] = LAYOUT_split_3x5_3(_x_, KC_F16, KC_F11, KC_F17, KC_F18, KC_F13, KC_F14, KC_F12, KC_F15, _x_,                                                               //
                               KC_F7, LGUI_T(KC_F5), LCTL_T(KC_F10), LALT_T(KC_F4), RALT_T(KC_F6), RALT_T(KC_F9), LALT_T(KC_F1), LCTL_T(KC_F2), LGUI_T(KC_F3), KC_F8,  //
                               _x_, KC_F19, KC_F20, KC_F21, _x_, _x_, KC_F22, KC_F23, KC_F24, _x_,                                                                     //
                               _x_, _x_, _x_, KC_LSHIFT, CC_EQU, _x_),

    [_NAV] = LAYOUT_split_3x5_3(_x_, _x_, KC_CAPS, _x_, _x_, _x_, KC_PGUP, KC_UP, KC_PGDN, _x_,                         //
                                _x_, KC_LGUI, KC_LCTRL, KC_LALT, KC_RALT, KC_HOME, KC_LEFT, KC_DOWN, KC_RIGHT, KC_END,  //
                                _x_, _x_, KC_PSCR, LALT(KC_PSCR), _x_, _x_, _x_, _x_, _x_, _x_,                         //
                                _x_, KC_LSHIFT, _x_, _x_, KC_LSHIFT, _x_),

    [_OS] = LAYOUT_split_3x5_3(_x_, KC_ACL1, _x_, KC_ACL2, _x_, _x_, _x_, KC_MS_U, _x_, _x_,                        //
                               KC_MS_BTN3, _x_, _x_, _x_, KC_RALT, KC_MUTE, KC_MS_L, KC_MS_D, KC_MS_R, KC_MS_BTN3,  //
                               _x_, KC_MS_WH_UP, _x_, KC_MS_WH_DOWN, _x_, _x_, KC_VOLU, KC_VOLD, KC_BRIU, KC_BRID,  //
                               _x_, KC_LSHIFT, KC_MS_BTN1, KC_MS_BTN2, KC_LSHIFT, KC_LCTRL),

    [_GAME] = LAYOUT_split_3x5_3(DF(_BASE), KC_Q, KC_W, KC_E, KC_R, _x_, _x_, _x_, KC_O, KC_P,  //
                                 KC_LSHIFT, KC_A, KC_S, KC_D, KC_F, _x_, _x_, _x_, KC_L, _x_,   //
                                 KC_LCTRL, KC_Z, KC_X, KC_C, KC_V, _x_, _x_, _x_, _x_, _x_,     //
                                 KC_ESC, KC_SPACE, KC_TAB, _x_, _x_, _x_),
};
