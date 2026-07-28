---
title: "vue中自动化引入组件，模块"
date: 2021-05-27
categories: "框架"
tags:
  - "vue"
recoveredFrom: "gh-pages"
---

<h2 id="背景"> 背景</h2> <blockquote><p>在日常引入组件，模块的时候，其实目录格式都差不多，能不能一键引入所有呢？<br>
通过查阅，<a href="https://cn.vuejs.org/v2/guide/components-registration.html#%E5%9F%BA%E7%A1%80%E7%BB%84%E4%BB%B6%E7%9A%84%E8%87%AA%E5%8A%A8%E5%8C%96%E5%85%A8%E5%B1%80%E6%B3%A8%E5%86%8C" target="_blank" rel="noopener noreferrer">require.context<span> </span></a>可以帮助我们实现这个功能。需要<code>vue-cli3+</code>的版本。</p></blockquote> <h2 id="require-context"> require.context</h2> <blockquote><p>如果你恰好使用了 webpack (或在内部使用了 webpack 的 Vue CLI 3+)，那么就可以使用 require.context 只全局注册这些非常通用的基础组件 ---摘自<a href="https://cn.vuejs.org/v2/guide/components-registration.html#%E5%9F%BA%E7%A1%80%E7%BB%84%E4%BB%B6%E7%9A%84%E8%87%AA%E5%8A%A8%E5%8C%96%E5%85%A8%E5%B1%80%E6%B3%A8%E5%86%8C" target="_blank" rel="noopener noreferrer">vue官方<span> </span></a></p></blockquote> <h2 id="_1、组件内-自动化引入"> 1、组件内-自动化引入</h2> <h3 id="目录"> 目录</h3> <ul>
<li>组件目录有两层，因为项目的特殊性，差不多有30个组件，一个一个引入非常麻烦
<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9e9c14dea5154be39464ae6cca833555~tplv-k3u1fbpfcp-watermark.image" alt="image.png">
</li> <li>传统引入, 万一有很多就麻烦了。。</li>
</ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">import</span> BaseButton <span class="token keyword">from</span> <span class="token string">'./BaseButton.vue'</span>
<span class="token keyword">import</span> BaseIcon <span class="token keyword">from</span> <span class="token string">'./BaseIcon.vue'</span>
<span class="token keyword">import</span> BaseInput <span class="token keyword">from</span> <span class="token string">'./BaseInput.vue'</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{</span>
  <span class="token literal-property property">components</span><span class="token operator">:</span> <span class="token punctuation">{</span>
    BaseButton<span class="token punctuation">,</span>
    BaseIcon<span class="token punctuation">,</span>
    BaseInput
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br>
</div>
</div>
<h3 id="自动化引入代码"> 自动化引入代码</h3> <ul><li>在组件内引入</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">const</span> requireComponent <span class="token operator">=</span> require<span class="token punctuation">.</span><span class="token function">context</span><span class="token punctuation">(</span>
    <span class="token comment">// 其组件目录的相对路径,这里根据实际目录而定</span>
    <span class="token string">'./companyModel'</span><span class="token punctuation">,</span>
    <span class="token comment">// 是否查询其子目录,我这里有两层，所以true</span>
    <span class="token boolean">true</span><span class="token punctuation">,</span>
    <span class="token comment">// 匹配基础组件文件名的正则表达式，我这里vue文件都要</span>
    <span class="token operator">/</span>\<span class="token punctuation">.</span>vue$<span class="token operator">/</span>
<span class="token punctuation">)</span>

<span class="token keyword">let</span> modules <span class="token operator">=</span> <span class="token punctuation">{</span><span class="token punctuation">}</span> <span class="token comment">//组件模块</span>

requireComponent<span class="token punctuation">.</span><span class="token function">keys</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">forEach</span><span class="token punctuation">(</span><span class="token parameter">ele</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
  <span class="token keyword">let</span> key <span class="token operator">=</span> ele<span class="token punctuation">.</span><span class="token function">split</span><span class="token punctuation">(</span><span class="token string">'/'</span><span class="token punctuation">)</span><span class="token punctuation">[</span><span class="token number">2</span><span class="token punctuation">]</span>
  key <span class="token operator">=</span> key<span class="token punctuation">.</span><span class="token function">substring</span><span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">,</span> key<span class="token punctuation">.</span>length<span class="token operator">-</span><span class="token number">4</span><span class="token punctuation">)</span> <span class="token comment">//获取文件名，不包含.vue,其实是模块名、PD1,PD2,PD3,ST1...</span>
  modules<span class="token punctuation">[</span>key<span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token function">requireComponent</span><span class="token punctuation">(</span>ele<span class="token punctuation">)</span><span class="token punctuation">.</span>default <span class="token comment">//模块实例赋值</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//最后塞入组件内</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{</span>
   <span class="token literal-property property">components</span><span class="token operator">:</span> modules<span class="token punctuation">,</span>
   <span class="token function">data</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span><span class="token punctuation">}</span> 
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br>
</div>
</div>
<h2 id="_2、vuex-模块自动化引入"> 2、vuex-模块自动化引入</h2> <ul><li>其实跟组件差不多，<code>vuex</code>的模块一定要<code>export</code>
</li></ul> <h3 id="目录-2"> 目录</h3> <ul><li>很传统的一个vuex目录</li></ul> <p><img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ec53c724d66749d084e1e2a7f93908b1~tplv-k3u1fbpfcp-watermark.image" alt="image.png"></p> <h3 id="自动化引入代码-2"> 自动化引入代码</h3> <ul><li>index.js内</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">let</span> ms <span class="token operator">=</span> require<span class="token punctuation">.</span><span class="token function">context</span><span class="token punctuation">(</span><span class="token string">'./modules'</span><span class="token punctuation">,</span> <span class="token boolean">false</span><span class="token punctuation">,</span> <span class="token regex"><span class="token regex-delimiter">/</span><span class="token regex-source language-regex">\.js$</span><span class="token regex-delimiter">/</span></span><span class="token punctuation">)</span> <span class="token comment">//这里只有一层，所以是false ,匹配js</span>
<span class="token keyword">let</span> modules <span class="token operator">=</span> <span class="token punctuation">{</span><span class="token punctuation">}</span>
ms<span class="token punctuation">.</span><span class="token function">keys</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">forEach</span><span class="token punctuation">(</span><span class="token parameter">ele</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
  <span class="token keyword">let</span> n <span class="token operator">=</span> ele<span class="token punctuation">.</span><span class="token function">substring</span><span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">,</span> ele<span class="token punctuation">.</span>length <span class="token operator">-</span> <span class="token number">3</span><span class="token punctuation">)</span> <span class="token comment">//一样，拿到文件名，去除后缀</span>
  modules<span class="token punctuation">[</span>n<span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token function">ms</span><span class="token punctuation">(</span>ele<span class="token punctuation">)</span><span class="token punctuation">.</span>default
<span class="token punctuation">}</span><span class="token punctuation">)</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token keyword">new</span> <span class="token class-name">Vuex<span class="token punctuation">.</span>Store</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
  modules<span class="token punctuation">,</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>

</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br>
</div>
</div>
<h2 id="_3、总结"> 3、总结</h2> <blockquote><p>我们可以通过<code>require.context</code>可以自动化引入文件。<br>
其实我们不单单局限于组件，路由内， 所有模块文件都是通用的， 例如路由， 接口封装模块，都是可以使用的。</p></blockquote>
