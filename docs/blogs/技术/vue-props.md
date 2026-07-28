---
title: "组件之props"
date: 2020-08-25
categories: "框架"
tags:
  - "vue"
recoveredFrom: "gh-pages"
---

<meta> <h2 id="基本用法"> 基本用法</h2> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token literal-property property">props</span><span class="token operator">:</span> <span class="token punctuation">[</span><span class="token string">'params1'</span><span class="token punctuation">,</span> <span class="token string">'params2'</span><span class="token punctuation">]</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br>
</div>
</div>
<h2 id="详细用法"> 详细用法</h2> <div class="language-json line-numbers-mode">
<pre class="language-json"><code><span class="token property">"refAge"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    type<span class="token operator">:</span> Number<span class="token punctuation">,</span>
    default<span class="token operator">:</span> <span class="token number">0</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token property">"refName"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    type<span class="token operator">:</span> String<span class="token punctuation">,</span>
    default<span class="token operator">:</span> ''
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token property">"hotDataLoading"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    type<span class="token operator">:</span> Boolean<span class="token punctuation">,</span>
    default<span class="token operator">:</span> <span class="token boolean">false</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token property">"hotData"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    type<span class="token operator">:</span> Array<span class="token punctuation">,</span>
    default<span class="token operator">:</span> () =&gt; <span class="token punctuation">{</span>
    return <span class="token punctuation">[</span><span class="token punctuation">]</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token property">"getParams"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    type<span class="token operator">:</span> Function<span class="token punctuation">,</span>
    default<span class="token operator">:</span> () =&gt; () =&gt; <span class="token punctuation">{</span><span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token property">"meta"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    type<span class="token operator">:</span> Object<span class="token punctuation">,</span>
    default<span class="token operator">:</span> () =&gt; (<span class="token punctuation">{</span><span class="token punctuation">}</span>)
<span class="token punctuation">}</span>
<span class="token property">"props"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
  title<span class="token operator">:</span> String<span class="token punctuation">,</span>
  likes<span class="token operator">:</span> Number<span class="token punctuation">,</span>
  isPublished<span class="token operator">:</span> Boolean<span class="token punctuation">,</span>
  commentIds<span class="token operator">:</span> Array<span class="token punctuation">,</span>
  author<span class="token operator">:</span> Object<span class="token punctuation">,</span>
  callback<span class="token operator">:</span> Function<span class="token punctuation">,</span>
  contactsPromise<span class="token operator">:</span> Promise <span class="token comment">// or any other constructor</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br><span class="line-number">29</span><br><span class="line-number">30</span><br><span class="line-number">31</span><br><span class="line-number">32</span><br><span class="line-number">33</span><br><span class="line-number">34</span><br><span class="line-number">35</span><br>
</div>
</div>
