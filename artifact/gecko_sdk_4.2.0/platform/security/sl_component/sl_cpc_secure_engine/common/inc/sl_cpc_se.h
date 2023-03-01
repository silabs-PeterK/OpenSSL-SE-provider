/***************************************************************************//**
 * @file
 * @brief Silicon Labs Secure Engine mailbox over CPC
 *******************************************************************************
 * # License
 * <b>Copyright 2023 Silicon Laboratories Inc. www.silabs.com</b>
 *******************************************************************************
 *
 * SPDX-License-Identifier: Zlib
 *
 * The licensor of this software is Silicon Laboratories Inc.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 ******************************************************************************/

#ifndef SL_CPC_SE_H
#define SL_CPC_SE_H

#ifdef __cplusplus
extern "C" {
#endif

// -----------------------------------------------------------------------------
// Macros

#define CMD_EXECUTE_SE_COMMAND           (0x01u)

#define REQUEST_COMMAND_TYPE_OFFSET         (0u)
#define REQUEST_COMMAND_TYPE_SIZE           (1u)
#define REQUEST_COMMAND_OFFSET              (RESPONSE_COMMAND_TYPE_OFFSET + RESPONSE_COMMAND_TYPE_SIZE)
#define REQUEST_COMMAND_SIZE                (4u)
#define REQUEST_NUM_PARAMS_OFFSET           (RESPONSE_COMMAND_OFFSET + RESPONSE_COMMAND_SIZE)
#define REQUEST_NUM_PARAMS_SIZE             (1u)
#define REQUEST_PARAMS_OFFSET               (REQUEST_NUM_PARAMS_OFFSET + REQUEST_NUM_PARAMS_SIZE)
#define REQUEST_PARAMS_ELEMENT_SIZE         (4u)
#define REQUEST_NUM_INPUTS_SIZE             (1u)
#define REQUEST_INPUT_LENGTHS_ELEMENT_SIZE  (4u)
#define REQUEST_NUM_OUTPUTS_SIZE            (1u)
#define REQUEST_OUTPUT_LENGTHS_ELEMENT_SIZE (4u)

#define RESPONSE_COMMAND_TYPE_OFFSET         (0u)
#define RESPONSE_COMMAND_TYPE_SIZE           (1u)
#define RESPONSE_COMMAND_OFFSET              (RESPONSE_COMMAND_TYPE_OFFSET + RESPONSE_COMMAND_TYPE_SIZE)
#define RESPONSE_COMMAND_SIZE                (4u)
#define RESPONSE_COMMAND_RESPONSE_OFFSET     (RESPONSE_COMMAND_OFFSET + RESPONSE_COMMAND_SIZE)
#define RESPONSE_COMMAND_RESPONSE_SIZE       (4u)
#define RESPONSE_NUM_OUTPUTS_OFFSET          (RESPONSE_COMMAND_RESPONSE_OFFSET + RESPONSE_COMMAND_RESPONSE_SIZE)
#define RESPONSE_NUM_OUTPUTS_SIZE            (1u)
#define RESPONSE_OUTPUT_LENGTHS_OFFSET       (RESPONSE_NUM_OUTPUTS_OFFSET + RESPONSE_NUM_OUTPUTS_SIZE)
#define RESPONSE_OUTPUT_LENGTHS_ELEMENT_SIZE (4u)

#ifdef __cplusplus
}
#endif

#endif // SL_CPC_SE_H
