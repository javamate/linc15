<#function sum nums...>
    <#local tot = 0 />
    <#list nums as num>
        <#local tot = tot + num>
    </#list>

    <#return tot?number />
</#function>

<#function promoted_topic id>
    <#local query = "SELECT c_msgmetadata_imageurl, post_time, post_time_friendly, view_href, conversation.solved, author.login, subject, body, replies.count(*), metrics.views, kudos.sum(weight), attachments.count(*) FROM messages Where conversation.style = 'forum' And depth = 0 And id = '${id}'" />
    <#local response = rest( '2.0', '/search?q=' + query?url ) />

    <#return response.data.items />
</#function>

<#function popular_topics id = 0>
    <#if ( id?number != 0 )>
        <#assign query_id = "And id = '127'" />
    <#else>
        <#assign query_id = '' />
    </#if>
    <#local query = "SELECT c_msgmetadata_imageurl, post_time, post_time_friendly, view_href, conversation.solved, author.login, subject, body, replies.count(*), metrics.views, kudos.sum(weight), attachments.count(*) FROM messages Where conversation.style = 'forum' And depth = 0 ${query_id} Limit 500" />
    <#local response = rest( '2.0', '/search?q=' + query?url ) />
    <#local topics = [] />

    <#local score_kudos       = settings.name.get( 'msgmetadata.kudos_weight' )?number!20 />
    <#local score_replies     = settings.name.get( 'msgmetadata.replies_weight' )?number!8 />
    <#local score_views       = settings.name.get( 'msgmetadata.views_weight' )?number!5 />
    <#local score_solved      = settings.name.get( 'msgmetadata.solutions_weight' )?number!4 />
    <#local score_attachments = settings.name.get( 'msgmetadata.attachments_weight' )?number!2 />

    <#list response.data.items as message>
        <#local kudos       = message.kudos.sum.weight * score_kudos />
        <#local replies     = message.replies.count * score_replies />
        <#local views       = message.metrics.views * score_views />
        <#local solved      = message.conversation.solved?string( '1', '0' )?number * score_solved />
        <#local attachments = message.attachments.count * score_attachments />
        <#local score       = sum( kudos, replies, views, solved, attachments ) />

        <#if ( message.post_time_friendly?? )>
            <#local time = message.post_time_friendly />
        <#else>
            <#local time = message.post_time?datetime?string />
        </#if>

        <#local body          = message.body?replace( "<[^>]*>", '', 'r' ) />
        <#local excerpt_limit = 150 />
        <#if ( message.body?length > excerpt_limit )>
            <#local excerpt = body[0..excerpt_limit] />
            <#local excerpt = excerpt + '...' />
        <#else>
            <#local excerpt = body />
        </#if>

        <#local topics = topics + [ {
            'message' : message,
            'time'    : time,
            'score'   : score,
            'excerpt' : excerpt ,
            'data'    : {
                'kudos'       : kudos,
                'replies'     : replies,
                'views'       : views,
                'solved'      : solved,
                'attachments' : attachments
            },
            'real_data' : {
                'kudos'       : message.kudos.sum.weight,
                'replies'     : message.replies.count,
                'views'       : message.metrics.views,
                'solved'      : message.conversation.solved?string( '1', '0' )?number,
                'attachments' : message.attachments.count
            }
        } ] />
    </#list>

    <#return topics?sort_by( 'score' )?reverse />
</#function>
