<#include 'custom.PopularTopics.Core.ftl'>
<#if ( coreNode.ancestors?size == 0 )>
    <#assign promoted_topic_id = settings.name.get( 'msgmetadata.promoted_threadid' ) />
    <#if ( promoted_topic_id != '' )>
        <#assign popular_topic = popular_topics( promoted_topic_id )?first />
    <#else>
        <#assign popular_topic = popular_topics()?first />
    </#if>

    <#attempt>
        <#assign background = popular_topic.message.c_msgmetadata_imageurl />
    <#recover>
        <#assign background = settings.name.get( 'msgmetadata.default_imageurl' ) />
    </#attempt>

    <style type="text/css">
    #lia-body.CommunityPage {
        background-image: none;
    }

    #lia-body.CommunityPage header {
        background-image: url( ${background} );
        background-size: cover;
    }

    #lia-body header #popular-topics-header .custom-header-welcome {
        top: 0;
        width: 520px;
        padding-right: 50px;
        text-align: left;
    }

    #lia-body header #popular-topics-header .custom-header-welcome:after {
        position: absolute;
        content: '';
        top: 50%;
        margin-top: -9px;
        right: 15px;
        width: 10px;
        height: 19px;
        background-size: cover;
        background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAATCAYAAACp65zuAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyNpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1NDkxMSwgMjAxMy8xMC8yOS0xMTo0NzoxNiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChNYWNpbnRvc2gpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkE3NTJGNzc5MDBEMzExRTU5NDM4QjQ5QzBDMzJDQTc2IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkE3NTJGNzdBMDBEMzExRTU5NDM4QjQ5QzBDMzJDQTc2Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6QTc1MkY3NzcwMEQzMTFFNTk0MzhCNDlDMEMzMkNBNzYiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6QTc1MkY3NzgwMEQzMTFFNTk0MzhCNDlDMEMzMkNBNzYiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4OfvYMAAAA0ElEQVR42mLg4OSUEpOU5GUgAFh0dXSOMDIyPACy/V89f/4Zl0Kmf//+Kv79+9dRQVZmIz6TmWAMQoqZkDn4FDOhC+BSzMTMzLyfGMXMv//9XyckIGDx//9/RWTFID5IHCT/9cuXX8wgghjFjDBBYzMrY4a/P85g8/Hv33/TwZ4BxQ7T/9+rsQYLM0vTpUsXZzGCFIFiBxTw2BSdPnWqHsRmNDU1vUdIETwKCSnCGuDYFGEoxKUIRSE+ReD0yMzCAgxXhmZ8isCAmNQNAgABBgASVHrxKh96hwAAAABJRU5ErkJggg==');
    }

    #popular-topics-header a,
    #popular-topics-header a h2,
    #popular-topics-header a p {
        text-decoration: none;
    }

    #popular-topics-header small {
        display: block;
        font-size: 13px;
        margin-bottom: 7px;
        font-weight: bold;
    }

    #popular-topics-header .info {
        display: block;
        margin-top: 4px;
        font-size: 13px;
    }

    #popular-topics-header a:hover {
        background-color: rgba( 255, 255, 255, 0.9 );
    }
    </style>

    <div id="popular-topics-header">
        <a class="custom-header-welcome" href="${popular_topic.message.view_href}">
            <small>popular thread</small>
            <h2>${popular_topic.message.subject}</h2>
            <span class="info">Posted by ${popular_topic.message.author.login} at ${popular_topic.time}</span>
            <p>${popular_topic.excerpt}</p>
        </a>
    </div>
</#if>
