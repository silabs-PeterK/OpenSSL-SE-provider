/**********************************************************************
*                          psa_eng.c                                *
*              Main file of PSA engine                              *
*                                                                    *
*             Copyright (c) 2005-2006 Cryptocom LTD                  *
*             Copyright (c) 2020 Chikunov Vitaly <vt@altlinux.org>   *
*                                                                    *
*       This file is distributed under the same license as OpenSSL   *
*                                                                    *
**********************************************************************/
#include <string.h>
#include <openssl/crypto.h>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <openssl/engine.h>
#include <openssl/obj_mac.h>

#include "common.h"
#include "implementations/psa_cipher.h"

#ifndef OSSL_NELEM
# define OSSL_NELEM(x) (sizeof(x) / sizeof((x)[0]))
#endif

static const char* engine_psa_id = "psaengine";

static const char* engine_psa_name =
  "Reference implementation of PSA engine";

/*
   void ERR_unload_PSA_strings(void)
   {
    if (error_loaded) {
 #ifndef OPENSSL_NO_ERR
 # ifndef OPENSSL_ERR_NEW_WORLD_ORDER
        ERR_unload_strings(lib_code, GOST_str_functs);
 # endif
        ERR_unload_strings(lib_code, GOST_str_reasons);
 #endif
        error_loaded = 0;
    }
   }*/

const ENGINE_CMD_DEFN psa_cmds[] = {
  /*
     {GOST_CTRL_CRYPT_PARAMS,
     "CRYPT_PARAMS",
     "OID of default GOST 28147-89 parameters",
     ENGINE_CMD_FLAG_STRING},

     {GOST_CTRL_PBE_PARAMS,
     "PBE_PARAMS",
     "Shortname of default digest alg for PBE",
     ENGINE_CMD_FLAG_STRING},
     {GOST_CTRL_PK_FORMAT,
     "GOST_PK_FORMAT",
     "Private key format params",
     ENGINE_CMD_FLAG_STRING},
   */
  { 0, NULL, NULL, 0 }
};

/* Symmetric cipher and digest function registrar */

static int psa_ciphers(ENGINE* e, const EVP_CIPHER** cipher,
                       const int** nids, int nid);

static int psa_digests(ENGINE* e, const EVP_MD** digest,
                       const int** nids, int nid);

static int psa_pkey_meths(ENGINE* e, EVP_PKEY_METHOD** pmeth,
                          const int** nids, int nid);

static int psa_pkey_asn1_meths(ENGINE* e, EVP_PKEY_ASN1_METHOD** ameth,
                               const int** nids, int nid);

/* ENGINE_DIGESTS_PTR callback installed by ENGINE_set_digests */
static int psa_digests(ENGINE *e, const EVP_MD **digest,
                       const int **nids, int nid)
{
  /*
     int i;

     if (!digest) {
        int *n = known_digest_nids;

   * nids = n;
        for (i = 0; i < OSSL_NELEM(gost_digest_array); i++)
   * n++ = gost_digest_array[i]->nid;
        return i;
     }

     for (i = 0; i < OSSL_NELEM(gost_digest_array); i++)
        if (nid == gost_digest_array[i]->nid) {
   * digest = GOST_init_digest(gost_digest_array[i]);
              return OPENSSL_SUCCESS;
        }*/
  *digest = NULL;
  return OPENSSL_FAILURE;
}



/* ENGINE_CIPHERS_PTR callback installed by ENGINE_set_ciphers */
static int psa_ciphers(ENGINE *e, const EVP_CIPHER **cipher,
                       const int **nids, int nid)
{
  int i;

  if (!cipher) {
    *nids = psa_cipher_nids;
    return OSSL_NELEM(psa_cipher_nids);
  }

  for (i = 0; i < OSSL_NELEM(psa_cipher_nids); i++) {
    if (nid == psa_cipher_array[i]->nid) {
      *cipher = PSA_initialize_cipher(psa_cipher_array[i]);

      return OPENSSL_SUCCESS;
    }
  }
  return OPENSSL_FAILURE;
}

/* ENGINE_PKEY_METHS_PTR installed by ENGINE_set_pkey_meths */
static int psa_pkey_meths(ENGINE *e, EVP_PKEY_METHOD **pmeth,
                          const int **nids, int nid)
{
  /*
     struct gost_meth_minfo *info;

     if (!pmeth)
        return gost_meth_nids(nids);

     for (info = gost_meth_array; info->nid; info++)
        if (nid == info->nid) {
   * pmeth = *info->pmeth;
            return OPENSSL_SUCCESS;
        }
   */
  *pmeth = NULL;
  return OPENSSL_FAILURE;
}

/* ENGINE_PKEY_ASN1_METHS_PTR installed by ENGINE_set_pkey_asn1_meths */
static int psa_pkey_asn1_meths(ENGINE *e, EVP_PKEY_ASN1_METHOD **ameth,
                               const int **nids, int nid)
{
  /*
     struct gost_meth_minfo *info;

     if (!ameth)
        return gost_meth_nids(nids);

     for (info = gost_meth_array; info->nid; info++)
        if (nid == info->nid) {
   * ameth = *info->ameth;
            return OPENSSL_SUCCESS;
        }
   * ameth = NULL;*/
  return OPENSSL_FAILURE;
}

static int psa_engine_init(ENGINE* e)
{
  return OPENSSL_SUCCESS;
}

static int psa_engine_finish(ENGINE* e)
{
  return OPENSSL_SUCCESS;
}

//static void free_NIDs();

static int psa_engine_destroy(ENGINE* e)
{
  int i;
/*
    for (i = 0; i < OSSL_NELEM(psa_digest_array); i++)
        PSA_deinit_digest(psa_digest_array[i]);
 */
  for (i = 0; i < OSSL_NELEM(psa_cipher_array); i++) {
    PSA_deinitialize_cipher(psa_cipher_array[i]);
  }

  // psa_param_free();

  // free_NIDs();

# ifndef BUILDING_PSA_PROVIDER
  // ERR_unload_PSA_strings();
# endif

  return OPENSSL_SUCCESS;
}

# ifndef BUILDING_PSA_PROVIDER
static
# endif
int populate_psa_engine(ENGINE* e)
{
  int ret = OPENSSL_FAILURE;

  if (e == NULL) {
    goto end;
  }
  if (!ENGINE_set_id(e, engine_psa_id)) {
    fprintf(stderr, "ENGINE_set_id failed\n");
    goto end;
  }
  if (!ENGINE_set_name(e, engine_psa_name)) {
    fprintf(stderr, "ENGINE_set_name failed\n");
    goto end;
  }
  /*
     if (!create_NIDs()) {
      fprintf(stderr, "NID creation failed\n");
      goto end;
     }
   */
  /*
     if (!ENGINE_set_digests(e, psa_digests)) {
      fprintf(stderr, "ENGINE_set_digests failed\n");
      goto end;
     }*/
  if (!ENGINE_set_ciphers(e, psa_ciphers)) {
    fprintf(stderr, "ENGINE_set_ciphers failed\n");
    goto end;
  }  /*
        if (!ENGINE_set_pkey_meths(e, psa_pkey_meths)) {
        fprintf(stderr, "ENGINE_set_pkey_meths failed\n");
        goto end;
        }
        if (!ENGINE_set_pkey_asn1_meths(e, psa_pkey_asn1_meths)) {
        fprintf(stderr, "ENGINE_set_pkey_asn1_meths failed\n");
        goto end;
        }*/
     /* Control function and commands */
  if (!ENGINE_set_cmd_defns(e, psa_cmds)) {
    fprintf(stderr, "ENGINE_set_cmd_defns failed\n");
    goto end;
  }
  /*
     if (!ENGINE_set_ctrl_function(e, psa_control_func)) {
      fprintf(stderr, "ENGINE_set_ctrl_func failed\n");
      goto end;
     }*/
  if (!ENGINE_set_destroy_function(e, psa_engine_destroy)
      || !ENGINE_set_init_function(e, psa_engine_init)
      || !ENGINE_set_finish_function(e, psa_engine_finish)) {
    goto end;
  }

  ret = OPENSSL_SUCCESS;
  end:
  return ret;
}

#ifndef BUILDING_PSA_PROVIDER
static int bind_psa_engine(ENGINE* e)
{
  int ret = OPENSSL_FAILURE;

  if (!ENGINE_register_ciphers(e)) {
    //   || !ENGINE_register_digests(e)
    //   || !ENGINE_register_pkey_meths(e))
    goto end;
  }

  int i;
  for (i = 0; i < OSSL_NELEM(psa_cipher_array); i++) {
    EVP_CIPHER * cipher = PSA_initialize_cipher(psa_cipher_array[i]);

    if (!EVP_add_cipher(psa_cipher_array[i]->evp_cipher)) {
      goto end;
    }
  }
/*
    for (i = 0; i < OSSL_NELEM(psa_digest_array); i++) {
        if (!EVP_add_digest(PSA_init_digest(psa_digest_array[i])))
            goto end;
    }
 */
  ENGINE_register_all_complete();

  //  ERR_load_PSA_strings();
  ret = OPENSSL_SUCCESS;
  end:
  return ret;
}

static int check_psa_engine(ENGINE* e, const char* id)
{
  if (id != NULL && strcmp(id, engine_psa_id) != 0) {
    return OPENSSL_FAILURE;
  }
  return OPENSSL_SUCCESS;
}

static int make_psa_engine(ENGINE* e, const char* id)
{
  return check_psa_engine(e, id)
         && populate_psa_engine(e)
         && bind_psa_engine(e);
}

#ifndef BUILDING_ENGINE_AS_LIBRARY

/*
 * When building psa-engine as a dynamically loadable module, these two
 * lines do everything that's needed, and OpenSSL's libcrypto will be able
 * to call its entry points, v_check and bind_engine.
 */

IMPLEMENT_DYNAMIC_BIND_FN(make_psa_engine)
IMPLEMENT_DYNAMIC_CHECK_FN()

#else

/*
 * When building psa-engine as a shared library, the application that uses
 * it must manually call ENGINE_load_psa() for it to bind itself into the
 * libcrypto libraries.
 */
void ENGINE_load_psa(void)
{
  ENGINE* toadd;
  int ret = 0;

  if ((toadd = ENGINE_new()) != NULL
      && (ret = make_psa_engine(toadd, engine_psa_id)) > 0) {
    ENGINE_add(toadd);
  }
  ENGINE_free(toadd);
  if (ret > 0) {
    ERR_clear_error();
  }
}
#endif
#endif
/* vim: set expandtab cinoptions=\:0,l1,t0,g0,(0 sw=4 : */
