---
title: "seo"
date: 2020-06-04
categories: "框架"
tags:
  - "vue"
recoveredFrom: "gh-pages"
---

<h2 id="seo-search-engine-optimization"> SEO(Search Engine Optimization)</h2> <ul><li>搜索引擎优化，更容易搜索到该页面。</li></ul> <h2 id="实现"> 实现</h2> <h3 id="_1、利用插件prerender-spa-plugin"> 1、利用插件<code>prerender-spa-plugin</code>
</h3> <ul>
<li><a href="https://github.com/chrisvfritz/prerender-spa-plugin" target="_blank" rel="noopener noreferrer">文档<span> </span></a></li> <li>node安装</li>
</ul> <div class="language- line-numbers-mode">
<pre class="language-text"><code>npm i prerender-spa-plugin -D
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br>
</div>
</div>
<ul><li>版本</li></ul> <div class="language-json line-numbers-mode">
<pre class="language-json"><code><span class="token punctuation">{</span>
  <span class="token property">"prerender-spa-plugin"</span><span class="token operator">:</span> <span class="token string">"^2.1.0"</span><span class="token punctuation">,</span>
  <span class="token property">"@vue/cli"</span><span class="token operator">:</span> <span class="token string">"~4.4.0"</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br>
</div>
</div>
<h3 id="_2、vue-config-js配置"> 2、<code>vue.config.js</code>配置</h3> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token comment">//prerender-spa-plugin</span>
<span class="token keyword">const</span> PrerenderSPAPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'prerender-spa-plugin'</span><span class="token punctuation">)</span>
<span class="token keyword">const</span> Renderer <span class="token operator">=</span> PrerenderSPAPlugin<span class="token punctuation">.</span>PuppeteerRenderer
module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>process<span class="token punctuation">.</span>env<span class="token punctuation">.</span><span class="token constant">NODE_ENV</span> <span class="token operator">===</span> <span class="token string">'production'</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
        <span class="token keyword">return</span> <span class="token punctuation">{</span>
          <span class="token literal-property property">plugins</span><span class="token operator">:</span> <span class="token punctuation">[</span>
            <span class="token keyword">new</span> <span class="token class-name">PrerenderSPAPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
              <span class="token comment">// 生成文件的路径，也可以与webpakc打包的一致。</span>
              <span class="token comment">// 下面这句话非常重要！！！</span>
              <span class="token comment">// 这个目录只能有一级，如果目录层次大于一级，在生成的时候不会有任何错误提示，在预渲染的时候只会卡着不动。</span>
              <span class="token literal-property property">staticDir</span><span class="token operator">:</span> path<span class="token punctuation">.</span><span class="token function">join</span><span class="token punctuation">(</span>__dirname<span class="token punctuation">,</span><span class="token string">'dist'</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
              <span class="token comment">// 对应自己的路由文件，比如a有参数，就需要写成 /a/param1。</span>
              <span class="token literal-property property">routes</span><span class="token operator">:</span> <span class="token punctuation">[</span><span class="token string">'/'</span><span class="token punctuation">,</span> <span class="token string">'/home'</span><span class="token punctuation">,</span> <span class="token string">'/page1'</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
              <span class="token comment">// 这个很重要，如果没有配置这段，也不会进行预编译</span>
              <span class="token literal-property property">renderer</span><span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">Renderer</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
                <span class="token literal-property property">inject</span><span class="token operator">:</span> <span class="token punctuation">{</span>
                  <span class="token literal-property property">foo</span><span class="token operator">:</span> <span class="token string">'bar'</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span>
                <span class="token comment">//headless: false,</span>
                <span class="token comment">// 在 main.js 中 document.dispatchEvent(new Event('render-event'))，两者的事件名称要对应上。</span>
                <span class="token literal-property property">renderAfterDocumentEvent</span><span class="token operator">:</span> <span class="token string">'render-event'</span>
              <span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token punctuation">]</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br>
</div>
</div>
<h3 id="_3、main-js配置"> 3、<code>main.js</code>配置</h3> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">new</span> <span class="token class-name">Vue</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
  <span class="token function">mounted</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
    document<span class="token punctuation">.</span><span class="token function">dispatchEvent</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">Event</span><span class="token punctuation">(</span><span class="token string">'render-event'</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">$mount</span><span class="token punctuation">(</span><span class="token string">'#app'</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br>
</div>
</div>
<h3 id="_4、路由配置"> 4、路由配置</h3> <ul><li>这里需要用<code>history</code>模式，必须！</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">const</span> <span class="token function-variable function">home</span> <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token keyword">import</span><span class="token punctuation">(</span><span class="token string">'@/views/home/home.vue'</span><span class="token punctuation">)</span>
<span class="token keyword">const</span> <span class="token function-variable function">page1</span> <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token keyword">import</span><span class="token punctuation">(</span><span class="token string">'@/views/home/page1.vue'</span><span class="token punctuation">)</span>
<span class="token keyword">const</span> routes <span class="token operator">=</span> <span class="token punctuation">[</span>
  <span class="token punctuation">{</span>
    <span class="token literal-property property">path</span><span class="token operator">:</span> <span class="token string">'/home'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'home'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">mode</span><span class="token operator">:</span> <span class="token string">'history'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">component</span><span class="token operator">:</span> home
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token punctuation">{</span>
    <span class="token literal-property property">path</span><span class="token operator">:</span> <span class="token string">'/page1'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'page1'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">mode</span><span class="token operator">:</span> <span class="token string">'history'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">component</span><span class="token operator">:</span> page1
  <span class="token punctuation">}</span>
<span class="token punctuation">]</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br>
</div>
</div>
<h3 id="_5、配置每个路由的meta"> 5、配置每个路由的<code>meta</code>
</h3> <ul>
<li>这里推荐使用<code>vue-meta</code>
</li> <li><a href="https://github.com/nuxt/vue-meta" target="_blank" rel="noopener noreferrer">文档<span> </span></a></li> <li>安装</li>
</ul> <div class="language- line-numbers-mode">
<pre class="language-text"><code>npm i vue-meta -D
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br>
</div>
</div>
<ul><li>在<code>main.js</code>中配置</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">import</span> VueMeta <span class="token keyword">from</span> <span class="token string">'vue-meta'</span>

Vue<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>VueMeta<span class="token punctuation">,</span> <span class="token punctuation">{</span>
  <span class="token comment">// optional pluginOptions</span>
  <span class="token literal-property property">refreshOnceOnNavigation</span><span class="token operator">:</span> <span class="token boolean">true</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br>
</div>
</div>
<ul><li>路由内的使用<code>home.vue</code>
</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{</span>
    <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'home'</span><span class="token punctuation">,</span>
    <span class="token literal-property property">components</span><span class="token operator">:</span> <span class="token punctuation">{</span><span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token literal-property property">metaInfo</span><span class="token operator">:</span> <span class="token punctuation">{</span>
      <span class="token literal-property property">title</span><span class="token operator">:</span> <span class="token string">'xxxx，代理进口公司-专注进口清关代理、国际海运、仓储物流服务'</span><span class="token punctuation">,</span>
      <span class="token literal-property property">meta</span><span class="token operator">:</span> <span class="token punctuation">[</span>
        <span class="token punctuation">{</span> <span class="token literal-property property">charset</span><span class="token operator">:</span> <span class="token string">'utf-8'</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">{</span> <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'keywords'</span><span class="token punctuation">,</span> <span class="token literal-property property">content</span><span class="token operator">:</span> <span class="token string">'代理进口公司,进口清关代理,国际海运,仓储物流,xxxx'</span><span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">{</span> <span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'description'</span><span class="token punctuation">,</span> <span class="token literal-property property">content</span><span class="token operator">:</span> <span class="token string">'xxxx是全球领先的进口清关跨境贸易综合服务平台'</span><span class="token punctuation">}</span>
      <span class="token punctuation">]</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br>
</div>
</div>
<ul><li>效果
<img src="https://github.com/zhoufanglu/markdownPhoto/blob/master/hexo/seo.png?raw=true" alt="页面效果">
</li></ul> <h2 id="最后打包"> 最后打包</h2> <div class="language- line-numbers-mode">
<pre class="language-text"><code>npm run build
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br>
</div>
</div>
<ul><li>
<code>dist</code>内的目录接口</li></ul> <div class="language- line-numbers-mode">
<pre class="language-text"><code>dist
│   css
│   js
|   index.html
└───home
│   │   index.html
└───|   
│   |
└───page1
    │   index.html
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br>
</div>
</div>
<ul><li>如果目录内是这样的解构说明成功了</li></ul> <h2 id="seo查询工具"> seo查询工具</h2> <ul><li><a href="https://www.sojson.com/seocheck/" target="_blank" rel="noopener noreferrer">地址<span> </span></a></li></ul> <h2 id="参考"> 参考</h2> <ul><li><a href="https://www.jianshu.com/p/6a4c0b281e7f" target="_blank" rel="noopener noreferrer">参考<span> </span></a></li></ul>
