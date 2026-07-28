---
title: "vue-初探vue3响应性基础"
date: 2020-10-16
categories: "框架"
tags:
  - "vue"
recoveredFrom: "gh-pages"
---

<meta> <blockquote><p>由于还不会jsx,先使用<code>vue3+typescript+template</code>模式<br>
网上还有一种<code>tsx+vue</code>模式
以下代码都使用vue3语法（vue3也可以使用vue2语法）</p></blockquote> <h2 id="_1、项目创建"> 1、项目创建</h2> <ul>
<li>官网需要vue-cli4+版本才能创建</li> <li><a href="https://cli.vuejs.org/zh/guide/creating-a-project.html" target="_blank" rel="noopener noreferrer">官网<span> </span></a></li> <li>选择vue3+typescript就可以</li>
</ul> <h2 id="_2、生命周期"> 2、生命周期</h2> <ul><li>与vue2对比，把beforCreate与created合并成了setUp(在他两之前执行)</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code>vue2<span class="token operator">--</span><span class="token operator">--</span><span class="token operator">--</span><span class="token operator">--</span><span class="token operator">--</span><span class="token operator">--</span><span class="token operator">-</span>vue3
<span class="token comment">//创建组件前后</span>
beforeCreate  <span class="token operator">-</span><span class="token operator">&gt;</span> <span class="token function">setup</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
created       <span class="token operator">-</span><span class="token operator">&gt;</span> <span class="token function">setup</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token comment">//组件挂载到dom前后</span>
beforeMount   <span class="token operator">-</span><span class="token operator">&gt;</span> onBeforeMount
mounted       <span class="token operator">-</span><span class="token operator">&gt;</span> onMounted
<span class="token comment">//组件更新前后</span>
beforeUpdate  <span class="token operator">-</span><span class="token operator">&gt;</span> onBeforeUpdate
updated       <span class="token operator">-</span><span class="token operator">&gt;</span> onUpdated
<span class="token comment">//组件销毁/删除前后</span>
beforeDestroy <span class="token operator">-</span><span class="token operator">&gt;</span> onBeforeUnmount
destroyed     <span class="token operator">-</span><span class="token operator">&gt;</span> onUnmounted
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br>
</div>
</div>
<ul><li>上代码</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token operator">&lt;</span>script lang<span class="token operator">=</span><span class="token string">"ts"</span><span class="token operator">&gt;</span>
<span class="token keyword">import</span> <span class="token punctuation">{</span> <span class="token comment">//现在使用的方法都要按需引入</span>
  onBeforeMount<span class="token punctuation">,</span>
  onMounted<span class="token punctuation">,</span>
  onBeforeUpdate<span class="token punctuation">,</span>
  onUpdated<span class="token punctuation">,</span>
  onBeforeUnmount<span class="token punctuation">,</span>
  onUnmounted
<span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">'vue'</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{</span>
  <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">"生命周期"</span><span class="token punctuation">,</span>
  <span class="token function">setup</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'1---setup,组件创建之前'</span><span class="token punctuation">)</span>
    <span class="token function">onBeforeMount</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'2---onBeforeMount,组件挂载到dom前'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token function">onMounted</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'3---onMounted,组件挂载到dom后'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token comment">//组件更新前后--比如数据更新后，会触发组件更新</span>
    <span class="token function">onBeforeUpdate</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'4---onBeforeUpdate,组件更新前'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token function">onUpdated</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'5---onUpdated,组件更新后'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token comment">//组件销毁前后  节点删除或替换会触发</span>
    <span class="token function">onBeforeUnmount</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'6---onBeforeUnmount，卸载组件前'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token function">onUnmounted</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'7---onBeforeUnmount，卸载组件后'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br><span class="line-number">29</span><br><span class="line-number">30</span><br><span class="line-number">31</span><br><span class="line-number">32</span><br><span class="line-number">33</span><br><span class="line-number">34</span><br><span class="line-number">35</span><br><span class="line-number">36</span><br><span class="line-number">37</span><br>
</div>
</div>
<ul><li>结果<br> <img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4dadf9ea416d4ad6a587385383d8ffc5~tplv-k3u1fbpfcp-watermark.image" alt="">
</li></ul> <h2 id="_3、响应式"> 3、响应式</h2> <ul><li><a href="https://vue3js.cn/docs/zh/api/basic-reactivity.html#reactive" target="_blank" rel="noopener noreferrer">api参考<span> </span></a></li></ul> <h3 id="_3-1-ref"> 3.1 ref</h3> <blockquote><p>一般使用于基本类型</p></blockquote> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">const</span> refCount <span class="token operator">=</span> ref<span class="token operator">&lt;</span>number<span class="token operator">&gt;</span><span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span>
refCount<span class="token punctuation">.</span>value <span class="token operator">=</span> <span class="token number">2</span> <span class="token comment">//修改时需要加上.value</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br>
</div>
</div>
<h3 id="_3-2-reactive"> 3.2 reactive</h3> <blockquote><p>一般使用于引用类型</p></blockquote> <ul>
<li><p>我们来实现一个标题点击选中的代码,效果如下<br> <img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5be40f1977bf4083ba50290c2ff1220d~tplv-k3u1fbpfcp-watermark.image" alt=""></p></li> <li><p>代码</p></li>
</ul> <p>template</p> <div class="language-html line-numbers-mode">
<pre class="language-html"><code><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>template</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>life-cycle<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>span</span> <span class="token attr-name">v-for</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>(i,index) in tabTitle.list<span class="token punctuation">"</span></span>
      <span class="token attr-name">:key</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>i<span class="token punctuation">"</span></span>
      <span class="token attr-name">@click</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>tabTitle.titleClick(index)<span class="token punctuation">"</span></span>
      <span class="token attr-name">:class</span><span class="token attr-value"><span class="token punctuation attr-equals">=</span><span class="token punctuation">"</span>i===tabTitle.currentTitle?'active':''<span class="token punctuation">"</span></span>
    <span class="token punctuation">&gt;</span></span>
      {{i}}
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>span</span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>当前选中的标题：{{tabTitle.currentTitle}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>template</span><span class="token punctuation">&gt;</span></span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br>
</div>
</div>
<p>script</p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token operator">&lt;</span>script lang<span class="token operator">=</span><span class="token string">"ts"</span><span class="token operator">&gt;</span>
<span class="token keyword">import</span> <span class="token punctuation">{</span>
  ref<span class="token punctuation">,</span>
  reactive
<span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">'vue'</span>
<span class="token comment">//定义接口</span>
<span class="token keyword">interface</span> <span class="token class-name">TabTitleProps</span> <span class="token punctuation">{</span>
  <span class="token literal-property property">list</span><span class="token operator">:</span> string<span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
  <span class="token literal-property property">currentTitle</span><span class="token operator">:</span> string<span class="token punctuation">,</span>
  <span class="token function-variable function">titleClick</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter"><span class="token literal-property property">index</span><span class="token operator">:</span> number</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token keyword">void</span>
<span class="token punctuation">}</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{</span>
  <span class="token function">setup</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
    <span class="token keyword">const</span> tabTitle <span class="token operator">=</span> reactive<span class="token operator">&lt;</span>TabTitleProps<span class="token operator">&gt;</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
      <span class="token literal-property property">list</span><span class="token operator">:</span> <span class="token punctuation">[</span><span class="token string">'标题A'</span><span class="token punctuation">,</span> <span class="token string">'标题B'</span><span class="token punctuation">,</span> <span class="token string">'标题C'</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
      <span class="token literal-property property">currentTitle</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
      <span class="token function-variable function">titleClick</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter"><span class="token literal-property property">index</span><span class="token operator">:</span>number</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
        tabTitle<span class="token punctuation">.</span>currentTitle <span class="token operator">=</span> tabTitle<span class="token punctuation">.</span>list<span class="token punctuation">[</span>index<span class="token punctuation">]</span>
      <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token comment">//可以理解为vue2中的data(){return{}}</span>
    <span class="token keyword">return</span> <span class="token punctuation">{</span>
      tabTitle
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br>
</div>
</div>
<h2 id="_4、template"> 4、template</h2> <ul><li>可以这么玩了</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token operator">&lt;</span>template<span class="token operator">&gt;</span>
	<span class="token operator">&lt;</span>div<span class="token operator">&gt;</span><span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>div<span class="token operator">&gt;</span><span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
<span class="token operator">&lt;</span>template<span class="token operator">&gt;</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br>
</div>
</div>
<h2 id="_5、watch"> 5、watch</h2> <ul><li>以下代码都在<code>setup</code>方法内执行，要引入<code>watch</code>
</li></ul> <h3 id="_5-1-监听单个值-ref"> 5.1 监听单个值（ref）</h3> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token comment">//watch</span>
    <span class="token comment">/**
     * refCount:监听的值， refCount 新的值， prevRefCount 旧的值
     */</span>
    <span class="token keyword">const</span> refCount <span class="token operator">=</span> ref<span class="token operator">&lt;</span>number<span class="token operator">&gt;</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span>
    <span class="token function">watch</span><span class="token punctuation">(</span>refCountTwo<span class="token punctuation">,</span> <span class="token punctuation">(</span>newVal<span class="token operator">:</span>number<span class="token punctuation">,</span> <span class="token literal-property property">oldVal</span><span class="token operator">:</span>number<span class="token punctuation">)</span><span class="token operator">:</span><span class="token parameter"><span class="token keyword">void</span></span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'new值'</span><span class="token punctuation">,</span> newVal<span class="token punctuation">)</span>  <span class="token comment">// 2</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'old值'</span><span class="token punctuation">,</span> oldVal<span class="token punctuation">)</span>  <span class="token comment">// 1</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'-------------'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      refCount<span class="token punctuation">.</span>value<span class="token operator">++</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">2000</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br>
</div>
</div>
<h3 id="_5-2-监听多个值-ref"> 5.2 监听多个值 (ref)</h3> <div class="language-js line-numbers-mode">
<pre class="language-js"><code>    <span class="token keyword">const</span> refCount <span class="token operator">=</span> ref<span class="token operator">&lt;</span>number<span class="token operator">&gt;</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span>
    <span class="token keyword">const</span> refCountTwo <span class="token operator">=</span> ref<span class="token operator">&lt;</span>number<span class="token operator">&gt;</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">)</span>
<span class="token comment">//watch 多个</span>
    <span class="token comment">/**
     * refCount:监听的值， refCount 新的值， prevRefCount 旧的值
     */</span>
    <span class="token function">watch</span><span class="token punctuation">(</span><span class="token punctuation">[</span>refCount<span class="token punctuation">,</span> refCountTwo<span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token punctuation">(</span>newVal<span class="token operator">:</span>number<span class="token punctuation">,</span> <span class="token literal-property property">oldVal</span><span class="token operator">:</span>number<span class="token punctuation">)</span><span class="token operator">:</span><span class="token parameter"><span class="token keyword">void</span></span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'new值'</span><span class="token punctuation">,</span> newVal<span class="token punctuation">)</span>  <span class="token comment">//[2, 101]</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'old值'</span><span class="token punctuation">,</span> oldVal<span class="token punctuation">)</span>  <span class="token comment">//[1, 100]</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'-------------'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    
    <span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      refCount<span class="token punctuation">.</span>value<span class="token operator">++</span>
      refCountTwo<span class="token punctuation">.</span>value<span class="token operator">++</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">2000</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br>
</div>
</div>
<h3 id="_5-3-深度监听-reactive"> 5.3 深度监听 (reactive)</h3> <div class="language-js line-numbers-mode">
<pre class="language-js"><code>cosnt person <span class="token operator">=</span> <span class="token punctuation">{</span>
    <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'lfz'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">age</span><span class="token operator">:</span> <span class="token number">11</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br>
</div>
</div>
<ul><li>例如要监听<code>person</code>内的<code>age</code>属性</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token function">setup</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{</span>
    <span class="token function">watch</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> personA<span class="token punctuation">.</span>age<span class="token punctuation">,</span> <span class="token punctuation">(</span>newVal<span class="token operator">:</span> number<span class="token punctuation">,</span> <span class="token literal-property property">oldVal</span><span class="token operator">:</span> number<span class="token punctuation">)</span><span class="token operator">:</span> <span class="token parameter"><span class="token keyword">void</span></span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'new值'</span><span class="token punctuation">,</span> newVal<span class="token punctuation">)</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'old值'</span><span class="token punctuation">,</span> oldVal<span class="token punctuation">)</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'-------------'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      personA<span class="token punctuation">.</span>age<span class="token operator">++</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span><span class="token number">1000</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br>
</div>
</div>
<h2 id="_6、watcheffect"> 6、watchEffect</h2> <ul>
<li>这个直接监听了所有值变化的问题</li> <li>感觉这个比<code>watch</code>好用</li>
</ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token comment">//改变person.age后就执行</span>
<span class="token function">watchEffect</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{</span>
      console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token number">36</span><span class="token punctuation">,</span> personA<span class="token punctuation">.</span>age<span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br>
</div>
</div>
<h2 id="_7、computed"> 7、computed</h2> <ul><li>template</li></ul> <div class="language-html line-numbers-mode">
<pre class="language-html"><code><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>template</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>a:{{a}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>b:{{b}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>a+b={{addVal}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>template</span><span class="token punctuation">&gt;</span></span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br>
</div>
</div>
<ul><li>script</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token operator">&lt;</span>script lang<span class="token operator">=</span><span class="token string">"ts"</span><span class="token operator">&gt;</span>
<span class="token keyword">import</span> <span class="token punctuation">{</span>ref<span class="token punctuation">,</span> computed<span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">'vue'</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{</span>
  <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">"computed"</span><span class="token punctuation">,</span>
  <span class="token function">setup</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{</span>
    <span class="token keyword">const</span> a <span class="token operator">=</span> ref<span class="token operator">&lt;</span>number<span class="token operator">&gt;</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span>
    <span class="token keyword">const</span> b <span class="token operator">=</span> ref<span class="token operator">&lt;</span>number<span class="token operator">&gt;</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span>
    <span class="token keyword">const</span> <span class="token literal-property property">addVal</span><span class="token operator">:</span>number <span class="token operator">=</span> <span class="token function">computed</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token operator">:</span><span class="token parameter">number</span><span class="token operator">=&gt;</span> a<span class="token punctuation">.</span>value<span class="token operator">+</span>b<span class="token punctuation">.</span>value<span class="token punctuation">)</span>
    <span class="token keyword">return</span> <span class="token punctuation">{</span>
      addVal<span class="token punctuation">,</span>
      a<span class="token punctuation">,</span>
      b
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br>
</div>
</div>
