---
title: "vite"
date: 2021-01-26
categories: "框架"
tags:
  - "vue"
recoveredFrom: "gh-pages"
---

<h2 id="介绍"> 介绍</h2> <ul>
<li>尤于溪的原话。
<img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ed5b9c461e08455496ee9fbbf60a16a1~tplv-k3u1fbpfcp-watermark.image" alt="">
</li> <li>
<code>vite</code>与<code>Vue CLI</code> 类似，<code>vite</code>也是一个提供基本项目脚手架和开发服务器的构建工具。</li> <li>
<code>vite</code>基于浏览器原生<code>ES imports</code>的开发服务器。跳过打包这个概念，服务端按需编译返回。</li> <li>
<code>vite</code>速度比<code>webpack</code>快<code>10+</code>倍，支持热跟新， 但是出于处于测试阶段。</li> <li>配置文件也支持热跟新！！！</li>
</ul> <h2 id="创建"> 创建</h2> <p>执行<code>npm init @vitejs/app</code> ，我这里选择的是<code>vue-ts</code></p> <p><img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4fa225caaf944f2b878a240d89a23e6d~tplv-k3u1fbpfcp-watermark.image" alt=""></p> <h2 id="版本"> 版本</h2> <div class="language- line-numbers-mode">
<pre class="language-text"><code>"vite": "^2.0.0-beta.48"
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br>
</div>
</div>
<h2 id="alias别名"> alias别名</h2> <p><code>vite.config.ts</code></p> <div class="language- line-numbers-mode">
<pre class="language-text"><code>const path = require('path')
  alias: {
    "@": path.resolve(__dirname, "src"),
    "@c": path.resolve(__dirname, "src/components")
  },
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br>
</div>
</div>
<p>1、
<code>npm i vue-router@4.0.2 --save</code>,安装4.0版本</p> <p>2、<code>index.ts</code></p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">import</span> <span class="token punctuation">{</span>createRouter<span class="token punctuation">,</span> createWebHashHistory<span class="token punctuation">,</span> RouteRecordRaw<span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">'vue-router'</span>
<span class="token comment">// @ts-ignore</span>
<span class="token keyword">const</span> <span class="token function-variable function">test</span> <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token keyword">import</span><span class="token punctuation">(</span><span class="token string">'../views/test1.vue'</span><span class="token punctuation">)</span>
<span class="token keyword">const</span> <span class="token literal-property property">routes</span><span class="token operator">:</span> Array<span class="token operator">&lt;</span>RouteRecordRaw<span class="token operator">&gt;</span> <span class="token operator">=</span> <span class="token punctuation">[</span>
    <span class="token punctuation">{</span><span class="token literal-property property">path</span><span class="token operator">:</span> <span class="token string">"/"</span><span class="token punctuation">,</span> <span class="token literal-property property">redirect</span><span class="token operator">:</span> <span class="token string">"/test1"</span><span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">{</span>
        <span class="token literal-property property">path</span><span class="token operator">:</span> <span class="token string">"/test1"</span><span class="token punctuation">,</span>
        <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'test1'</span><span class="token punctuation">,</span>
        <span class="token literal-property property">component</span><span class="token operator">:</span> test<span class="token punctuation">,</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">]</span>
<span class="token keyword">const</span> router <span class="token operator">=</span> <span class="token function">createRouter</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
    <span class="token literal-property property">history</span><span class="token operator">:</span> <span class="token function">createWebHashHistory</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token literal-property property">routes</span><span class="token operator">:</span> routes
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> router
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br>
</div>
</div>
<p>3、 <code>main.ts</code></p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">import</span> router <span class="token keyword">from</span> <span class="token string">"./router"</span>
<span class="token function">createApp</span><span class="token punctuation">(</span>App<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>router<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">mount</span><span class="token punctuation">(</span><span class="token string">'#app'</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br>
</div>
</div>
<h3 id="添加vuex-版本同样要4以上"> 添加vuex(版本同样要4以上)</h3> <p>1、安装
<code>npm i vuex@index -D</code></p> <p>2、<code>store/index.ts</code></p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">import</span> <span class="token punctuation">{</span> createStore <span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">'vuex'</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token function">createStore</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
  <span class="token literal-property property">state</span><span class="token operator">:</span> <span class="token punctuation">{</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token comment">//...</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>

</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br>
</div>
</div>
<p>3、<code>main.ts</code></p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">import</span> store <span class="token keyword">from</span> <span class="token string">'./store'</span>

<span class="token function">createApp</span><span class="token punctuation">(</span>App<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>store<span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">mount</span><span class="token punctuation">(</span><span class="token string">'#app'</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br>
</div>
</div>
<h3 id="scss环境"> scss环境</h3> <p>1、安装<code>npm i sass -D</code>，可以直接使用sass语法了
2、vite.config.ts,全局引入scss文件</p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token literal-property property">css</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    <span class="token literal-property property">preprocessorOptions</span><span class="token operator">:</span> <span class="token punctuation">{</span>
      <span class="token literal-property property">scss</span><span class="token operator">:</span> <span class="token punctuation">{</span>
        <span class="token literal-property property">additionalData</span><span class="token operator">:</span> <span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">@import "./src/assets/scss/global.scss";</span><span class="token template-punctuation string">`</span></span><span class="token comment">//你的scss文件路径</span>
      <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br>
</div>
</div>
