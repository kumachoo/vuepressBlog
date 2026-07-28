---
title: "生命周期"
date: 2020-09-25
categories: "框架"
tags:
  - "vue"
recoveredFrom: "gh-pages"
---

<meta> <h2 id="父子组件生命周期"> 父子组件生命周期</h2> <div class="language-html line-numbers-mode">
<pre class="language-html"><code><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>father<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>children</span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>child<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>children</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br>
</div>
</div>
<p>结果<br>
1、父组件<code>created</code><br>
2、子组件<code>created</code><br>
3、子组件<code>mounted</code><br>
4、父组件<code>mounted</code></p>
