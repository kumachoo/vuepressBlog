---
title: "路由模式"
categories: "框架"
tags:
  - "vue"
recoveredFrom: "gh-pages"
---

<meta> <p><a href="https://juejin.im/post/5ceedf8ff265da1b80202841" target="_blank" rel="noopener noreferrer">参考<span> </span></a><br> <a href="https://router.vuejs.org/zh/guide/essentials/history-mode.html" target="_blank" rel="noopener noreferrer">官方文档<span> </span></a></p> <h2 id="hash"> hash</h2> <ul>
<li>
<code>url</code>带有<code>#</code>号</li> <li>
<code>url</code>与页面是有关联的，可以利用<code>onhashchange</code>监听<code>url</code>变化</li>
</ul> <h2 id="history"> history</h2> <ul><li>说说html5的history方法吧</li></ul> <h3 id="pushstate-state-object-title-page"> pushState(state object, title, page)</h3> <ul>
<li>一个状态对象, 一个标题 (FireFox目前被忽略), 和 (可选的) 一个URL</li> <li>不会触发hashchange事件</li> <li>新建了历史记录
1、假设有两个页面<code>foo.html</code>,<code>bar.html</code>
在<code>foo.html</code>中执行以下Js</li>
</ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">var</span> stateObj <span class="token operator">=</span> <span class="token punctuation">{</span> <span class="token literal-property property">value</span><span class="token operator">:</span> <span class="token string">"111"</span> <span class="token punctuation">}</span><span class="token punctuation">;</span>
history<span class="token punctuation">.</span><span class="token function">pushState</span><span class="token punctuation">(</span>stateObj<span class="token punctuation">,</span> <span class="token string">"bar"</span><span class="token punctuation">,</span> <span class="token string">"bar.html"</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br>
</div>
</div>
<p>代码执行完毕之后，我们可以发现<code>url</code>进行了跳转，但是内容没有变化，刷新之后又可以见了。</p> <h3 id="replacestate"> replaceState()</h3> <ul><li>效果与上面一样，但是是修改了当前页面的历史记录。而不是新建一个。</li></ul> <h2 id="vue路由的实现原理"> vue路由的实现原理</h2> <p><a href="https://juejin.im/post/5c52da9ee51d45221f242804" target="_blank" rel="noopener noreferrer">参考<span> </span></a></p> <ul>
<li>hash 通过hashChange监听url的变化，来改变页面的内容</li> <li>history 是通过history.pushState来进行跳转和记录内容，通过监听popstate事件进行改变页面的内容</li>
</ul>
