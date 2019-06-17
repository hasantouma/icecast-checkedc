/* Icecast
 *
 * This program is distributed under the GNU General Public License, version 2.
 * A copy of this license is included with this source.
 *
 * Copyright 2000-2004, Jack Moffitt <jack@xiph.org, 
 *                      Michael Smith <msmith@xiph.org>,
 *                      oddsock <oddsock@xiph.org>,
 *                      Karl Heyes <karl@xiph.org>
 *                      and others (see AUTHORS for details).
 */

/* format.h
**
** format plugin header
**
*/
#ifndef __FORMAT_H__
#define __FORMAT_H__

#include "client.h"
#include "refbuf.h"
#include "httpp/httpp.h"

struct source_tag;
struct _mount_proxy;

typedef enum _format_type_tag
{
    FORMAT_ERROR, /* No format, source not processable */
    FORMAT_TYPE_OGG,
    FORMAT_TYPE_EBML,
    FORMAT_TYPE_GENERIC
} format_type_t;

typedef struct _format_plugin_tag
{
    format_type_t type;

    /* we need to know the mount to report statistics */
    _Ptr<char> mount;

    const char *contenttype;
    char *charset;
    uint64_t read_bytes;
    uint64_t sent_bytes;

    _Ptr<refbuf_t* (struct source_tag* )> get_buffer;
    _Ptr<int (client_t* )> write_buf_to_client;
    _Ptr<void (struct source_tag* , refbuf_t* )> write_buf_to_file;
    _Ptr<int (struct source_tag* , client_t* )> create_client_data;
    _Ptr<void (struct _format_plugin_tag* , const char* , const char* , const char* )> set_tag;
    _Ptr<void (struct _format_plugin_tag* )> free_plugin;
    _Ptr<void (client_t* , struct _format_plugin_tag* , struct _mount_proxy* )> apply_settings;

    /* for internal state management */
    void *_state;
} format_plugin_t;

format_type_t format_get_type(const char *contenttype);
char *format_get_mimetype(format_type_t type);
int format_get_plugin(format_type_t type, struct source_tag *source);

int format_generic_write_to_client (client_t *client);
int format_advance_queue (struct source_tag *source, client_t *client);
int format_check_http_buffer (struct source_tag *source, client_t *client);
int format_check_file_buffer (struct source_tag *source, client_t *client);

void format_send_general_headers(format_plugin_t *format, 
        struct source_tag *source, client_t *client);

#endif  /* __FORMAT_H__ */

