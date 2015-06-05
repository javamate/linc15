<#include 'custom.PopularTopics.Core.ftl'/>
<#assign popular_topics = popular_topics()[0..2] />

<style type="text/css">
.popular-topics-list-message-author {
  float: left;
  margin-right: 10px;
  font-size: smaller;
}
.popular-topics-list-message-time {
	font-size: smaller;
}
</style>

<div id="popular-topics-list">
    <div>
		<#list popular_topics as popular_topic>
			<div class="popular-topics-list-message">
				<a href="${popular_topic.message.view_href}">${popular_topic.message.subject}</a>
			</div>
			<div class="popular-topics-list-message-excerpt">
				${popular_topic.excerpt}
			</div>
			<div class="popular-topics-list-message-author">
				${popular_topic.message.author.login}
			</div>
			<div class="popular-topics-list-message-time">
				${popular_topic.time}
			</div>
		</#list>
	</div>
</div>