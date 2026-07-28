---
title: "vue中动态路由实现"
date: 2021-05-17
categories: "框架"
tags:
  - "vue"
sticky: 2
recoveredFrom: "gh-pages"
---

<h2 id="前言"> 前言</h2> <ul><li>路由版本 ,<code>router.3x</code>
</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token string-property property">"vue-router"</span><span class="token operator">:</span> <span class="token string">"^3.5.2"</span><span class="token punctuation">,</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br>
</div>
</div>
<ul>
<li>需要看<code>router.4x</code> 的请看这里<a href="https://juejin.cn/post/7043988643941203975/" target="_blank" rel="noopener noreferrer">手摸手教你实现vue的动态路由（router.v4.x版本）<span> </span></a>
</li> <li>源代码地址 <a href="https://github.com/zhoufanglu/dynamic-vue-router" target="_blank" rel="noopener noreferrer">dynamic-vue-router<span> </span></a>, <code>vue2</code>语法</li>
</ul> <h2 id="代码已经上传到github"> 代码已经上传到github</h2> <p><a href="https://github.com/zhoufanglu/dynamic-vue-router" target="_blank" rel="noopener noreferrer">代码地址<span> </span></a>
有用求个<code>star</code></p> <h2 id="流程"> 流程</h2> <p>1、用户登陆，获取后端返回的路由
2、使用<code>router.addRoute</code>动态添加到路由 <a href="https://router.vuejs.org/zh/api/#router-addroutes" target="_blank" rel="noopener noreferrer">文档<span> </span></a>
3、使用<code>router.getRoutes</code>读取路由 <a href="https://router.vuejs.org/zh/api/#router-addroute-2" target="_blank" rel="noopener noreferrer">文档<span> </span></a>
4、注销的时候，把路由重置到登陆前的数据。</p> <h2 id="注意点"> 注意点</h2> <ul>
<li><p>路由版本：<code>"vue-router": "^3.2.0",</code></p></li> <li><p><strong>官方已经废弃了<code>addRoutes</code></strong></p></li> <li><p>目前应该使用<code>addRoute</code>!!!</p></li> <li><p>获取路由函数<code>router.getRoutes()</code>返回的数组不会有层级，会把子路由提到最外面一层。</p></li>
</ul> <h2 id="核心代码介绍"> 核心代码介绍</h2> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token comment">//模拟后端传的路由</span>
<span class="token keyword">export</span> <span class="token keyword">const</span> authRouter <span class="token operator">=</span> <span class="token punctuation">[</span>
<span class="token punctuation">{</span>
<span class="token literal-property property">path</span><span class="token operator">:</span> <span class="token string">'/allSeePage'</span><span class="token punctuation">,</span>
<span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'所有人可见'</span><span class="token punctuation">,</span>
<span class="token literal-property property">component</span><span class="token operator">:</span> <span class="token string">'allSeePage'</span> <span class="token comment">//后面我们使用require([`@/views/${view}`], resolve) 进行动态加载</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">{</span>
<span class="token literal-property property">path</span><span class="token operator">:</span> <span class="token string">'/adminPage'</span><span class="token punctuation">,</span>
<span class="token literal-property property">name</span><span class="token operator">:</span> <span class="token string">'管理员可见'</span><span class="token punctuation">,</span>
<span class="token literal-property property">component</span><span class="token operator">:</span> <span class="token string">'adminPage'</span>
<span class="token punctuation">}</span>
<span class="token punctuation">]</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br>
</div>
</div>
<blockquote><p>我把<code>登陆</code>、<code>注销</code>、<code>添加路由</code>、方法都放在<code>vuex</code>内了</p></blockquote> <h3 id="_1、state"> 1、state</h3> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token literal-property property">state</span><span class="token operator">:</span> <span class="token punctuation">{</span>
<span class="token literal-property property">userInfo</span><span class="token operator">:</span> <span class="token punctuation">{</span>
<span class="token literal-property property">userName</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">password</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">token</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">routerList</span><span class="token operator">:</span> <span class="token punctuation">[</span><span class="token punctuation">]</span> <span class="token comment">//存放后端返回的路由列表</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br>
</div>
</div>
<h3 id="_2、vuex内添加路由方法-add-route"> 2、vuex内添加路由方法 ADD_ROUTE</h3> <p><code>vuex-mutaions</code></p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token literal-property property">mutations</span><span class="token operator">:</span> <span class="token punctuation">{</span>
<span class="token constant">ADD_ROUTE</span><span class="token punctuation">(</span><span class="token parameter">state</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token keyword">let</span> routerList <span class="token operator">=</span> <span class="token constant">JSON</span><span class="token punctuation">.</span><span class="token function">parse</span><span class="token punctuation">(</span><span class="token constant">JSON</span><span class="token punctuation">.</span><span class="token function">stringify</span><span class="token punctuation">(</span>state<span class="token punctuation">.</span>userInfo<span class="token punctuation">.</span>routerList<span class="token punctuation">)</span><span class="token punctuation">)</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token number">26</span><span class="token punctuation">,</span> router<span class="token punctuation">.</span><span class="token function">getRoutes</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span>length<span class="token punctuation">)</span>
<span class="token comment">//路由未添加之前是4个,添加完之后是6个，我们用是否小于6个，来判断是否要添加</span>
<span class="token keyword">if</span> <span class="token punctuation">(</span>router<span class="token punctuation">.</span><span class="token function">getRoutes</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span>length <span class="token operator">&lt;</span> <span class="token number">6</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
routerList <span class="token operator">=</span> <span class="token function">filterAsyncRouter</span><span class="token punctuation">(</span>routerList<span class="token punctuation">)</span><span class="token comment">//路由动态添加</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'路由添加前'</span><span class="token punctuation">,</span> router<span class="token punctuation">.</span><span class="token function">getRoutes</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
routerList<span class="token punctuation">.</span><span class="token function">forEach</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token parameter">i</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
<span class="token comment">//在home父路由内添加子路由</span>
router<span class="token punctuation">.</span><span class="token function">addRoute</span><span class="token punctuation">(</span><span class="token string">'home'</span><span class="token punctuation">,</span> i<span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'路由添加后'</span><span class="token punctuation">,</span> router<span class="token punctuation">.</span><span class="token function">getRoutes</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br>
</div>
</div>
<h3 id="_2、登陆"> 2、登陆</h3> <blockquote><p>主要就是读取登陆接口路由，然后把路由添加进去</p></blockquote> <ul><li><code>vuex</code></li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token literal-property property">state</span><span class="token operator">:</span> <span class="token punctuation">{</span>
<span class="token literal-property property">userInfo</span><span class="token operator">:</span> <span class="token punctuation">{</span>
<span class="token literal-property property">userName</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">password</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">token</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">routerList</span><span class="token operator">:</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">,</span><span class="token comment">//当前登陆用户的路由列表-由后端传过来</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token literal-property property">mutations</span><span class="token operator">:</span> <span class="token punctuation">{</span>
<span class="token constant">SET_USER_INFO</span><span class="token punctuation">(</span><span class="token parameter">state<span class="token punctuation">,</span> val</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
state<span class="token punctuation">.</span>userInfo <span class="token operator">=</span> Object<span class="token punctuation">.</span><span class="token function">assign</span><span class="token punctuation">(</span>state<span class="token punctuation">.</span>userInfo<span class="token punctuation">,</span> val<span class="token punctuation">)</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token literal-property property">actions</span><span class="token operator">:</span> <span class="token punctuation">{</span>
<span class="token comment">//登陆</span>
<span class="token function">login</span><span class="token punctuation">(</span><span class="token parameter"><span class="token punctuation">{</span> commit <span class="token punctuation">}</span><span class="token punctuation">,</span> userInfo</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token keyword">const</span> <span class="token punctuation">{</span> userName<span class="token punctuation">,</span> password <span class="token punctuation">}</span> <span class="token operator">=</span> userInfo
<span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Promise</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token parameter">resolve</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
<span class="token comment">//模拟登陆，获取用户信息， 权限路由列表</span>
<span class="token comment">//假设返回的有token, 路由列表(根据不同用户返回不同)</span>
<span class="token comment">/**********************模拟后端传过来的路由列表----S***********************/</span>
<span class="token keyword">let</span> routerList <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span>
<span class="token keyword">if</span> <span class="token punctuation">(</span>userName <span class="token operator">===</span> <span class="token string">'admin'</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
routerList <span class="token operator">=</span> authRouter
<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token keyword">if</span> <span class="token punctuation">(</span>userName <span class="token operator">===</span> <span class="token string">'commonUser'</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
routerList <span class="token operator">=</span> <span class="token punctuation">[</span>authRouter<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">]</span>
<span class="token punctuation">}</span>
<span class="token comment">/**********************模拟后端传过来的路由列表----E***********************/</span>
<span class="token keyword">let</span> token <span class="token operator">=</span> <span class="token string">'testToken'</span>
<span class="token comment">//把用户信息存入vuex</span>
<span class="token function">commit</span><span class="token punctuation">(</span><span class="token string">'SET_USER_INFO'</span><span class="token punctuation">,</span> <span class="token punctuation">{</span>
userName<span class="token punctuation">,</span>
password<span class="token punctuation">,</span>
token<span class="token punctuation">,</span>
routerList
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//添加路由</span>
<span class="token function">commit</span><span class="token punctuation">(</span><span class="token string">'ADD_ROUTE'</span><span class="token punctuation">)</span>
<span class="token function">resolve</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br><span class="line-number">29</span><br><span class="line-number">30</span><br><span class="line-number">31</span><br><span class="line-number">32</span><br><span class="line-number">33</span><br><span class="line-number">34</span><br><span class="line-number">35</span><br><span class="line-number">36</span><br><span class="line-number">37</span><br><span class="line-number">38</span><br><span class="line-number">39</span><br><span class="line-number">40</span><br><span class="line-number">41</span><br><span class="line-number">42</span><br>
</div>
</div>
<h3 id="_3、注销-重置路由"> 3、注销-重置路由</h3> <p><code>vuex-actions</code></p> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token literal-property property">actions</span><span class="token operator">:</span><span class="token punctuation">{</span>
<span class="token comment">//注销</span>
<span class="token function">logout</span><span class="token punctuation">(</span><span class="token parameter"><span class="token punctuation">{</span> commit<span class="token punctuation">,</span> state <span class="token punctuation">}</span></span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Promise</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token parameter">resolve</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>state<span class="token punctuation">.</span>userInfo<span class="token punctuation">.</span>token<span class="token punctuation">,</span> <span class="token string">'注销了'</span><span class="token punctuation">)</span>
<span class="token function">commit</span><span class="token punctuation">(</span><span class="token string">'SET_USER_INFO'</span><span class="token punctuation">,</span> <span class="token punctuation">{</span>
<span class="token literal-property property">userName</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">password</span><span class="token operator">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
<span class="token literal-property property">token</span><span class="token operator">:</span> <span class="token string">''</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//重置路由</span>
<span class="token function">resetRouter</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token comment">//这是路由里面的重置方法，引入的</span>
<span class="token function">resolve</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br>
</div>
</div>
<h3 id="_4、渲染菜单"> 4、渲染菜单</h3> <blockquote><p>利用<code>router.getRoutes()</code>,获取已经添加的路由，此方法会把所有层级变为一层，子路由会有parent属性
最后渲染到页面上
在左侧导航组件内</p></blockquote> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">let</span> routeList <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">.</span>$router<span class="token punctuation">.</span><span class="token function">getRoutes</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token comment">//查找home路由的子路由，然后渲染出来</span>
<span class="token keyword">this</span><span class="token punctuation">.</span>menuList <span class="token operator">=</span> routeList<span class="token punctuation">.</span><span class="token function">filter</span><span class="token punctuation">(</span>
<span class="token punctuation">(</span><span class="token parameter">i</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> i<span class="token punctuation">.</span>parent <span class="token operator">&amp;&amp;</span> i<span class="token punctuation">.</span>parent<span class="token punctuation">.</span>name <span class="token operator">===</span> <span class="token string">'home'</span>
<span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br>
</div>
</div>
<ul><li>重置路由方法
<code>permission.js</code>
</li></ul> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token comment">//路由的创建</span>
<span class="token keyword">const</span> <span class="token function-variable function">createRouter</span> <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span>
<span class="token keyword">new</span> <span class="token class-name">VueRouter</span><span class="token punctuation">(</span><span class="token punctuation">{</span>
<span class="token function-variable function">scrollBehavior</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">(</span><span class="token punctuation">{</span> <span class="token literal-property property">y</span><span class="token operator">:</span> <span class="token number">0</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token literal-property property">routes</span><span class="token operator">:</span> constantRoutes
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//重置路由</span>
<span class="token keyword">export</span> <span class="token keyword">function</span> <span class="token function">resetRouter</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token keyword">const</span> newRouter <span class="token operator">=</span> <span class="token function">createRouter</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
router<span class="token punctuation">.</span>matcher <span class="token operator">=</span> newRouter<span class="token punctuation">.</span>matcher <span class="token comment">// reset router</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">const</span> router <span class="token operator">=</span> <span class="token function">createRouter</span><span class="token punctuation">(</span><span class="token punctuation">)</span>

</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br>
</div>
</div>
<h2 id="路由钩子函数beforeeach"> 路由钩子函数<code>beforeEach</code>
</h2> <blockquote><p>流程</p></blockquote> <blockquote><p>代码</p></blockquote> <div class="language-js line-numbers-mode">
<pre class="language-js"><code>router<span class="token punctuation">.</span><span class="token function">beforeEach</span><span class="token punctuation">(</span><span class="token keyword">async</span> <span class="token punctuation">(</span><span class="token parameter">to<span class="token punctuation">,</span> from<span class="token punctuation">,</span> next</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
<span class="token comment">//获取用户信息</span>
<span class="token keyword">let</span> <span class="token punctuation">{</span> userInfo <span class="token punctuation">}</span> <span class="token operator">=</span> store<span class="token punctuation">.</span>state
<span class="token keyword">const</span> <span class="token punctuation">{</span> userName <span class="token punctuation">}</span> <span class="token operator">=</span> userInfo
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'用户角色'</span><span class="token punctuation">,</span> userName <span class="token operator">?</span> userName <span class="token operator">:</span> <span class="token string">'未登陆'</span><span class="token punctuation">)</span>
<span class="token comment">//有用户信息</span>
<span class="token keyword">if</span> <span class="token punctuation">(</span>userName<span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token keyword">await</span> store<span class="token punctuation">.</span><span class="token function">dispatch</span><span class="token punctuation">(</span><span class="token string">'addRoute'</span><span class="token punctuation">)</span>
<span class="token keyword">let</span> <span class="token punctuation">{</span> routerList <span class="token punctuation">}</span> <span class="token operator">=</span> userInfo
<span class="token comment">//根据to.name来判断是否为动态路由, 是否有人知道还有更好的判断方法？</span>
<span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>to<span class="token punctuation">.</span>name<span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token comment">//当前路由是动态的，确定是有的, 有就跳自己，没有就跳404</span>
<span class="token keyword">if</span> <span class="token punctuation">(</span>routerList<span class="token punctuation">.</span><span class="token function">findIndex</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token parameter">i</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> i<span class="token punctuation">.</span>path <span class="token operator">===</span> to<span class="token punctuation">.</span>path<span class="token punctuation">)</span> <span class="token operator">!==</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token function">next</span><span class="token punctuation">(</span><span class="token punctuation">{</span> <span class="token operator">...</span>to<span class="token punctuation">,</span> <span class="token literal-property property">replace</span><span class="token operator">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{</span>
<span class="token function">next</span><span class="token punctuation">(</span><span class="token string">'/404'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{</span>
<span class="token function">next</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token comment">//无用户信息</span>
<span class="token keyword">else</span> <span class="token punctuation">{</span>
<span class="token comment">//没有权限访问，跳入没有权限页面/或者登陆页面</span>
<span class="token comment">// 跳转之前要判断一下是否为需要跳转的界面，不然会进入死循环</span>
<span class="token keyword">if</span> <span class="token punctuation">(</span>to<span class="token punctuation">.</span>path <span class="token operator">===</span> <span class="token string">'/login'</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
<span class="token function">next</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{</span>
Message<span class="token punctuation">.</span><span class="token function">error</span><span class="token punctuation">(</span><span class="token string">'请先登陆！'</span><span class="token punctuation">)</span>
<span class="token function">next</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br><span class="line-number">5</span><br><span class="line-number">6</span><br><span class="line-number">7</span><br><span class="line-number">8</span><br><span class="line-number">9</span><br><span class="line-number">10</span><br><span class="line-number">11</span><br><span class="line-number">12</span><br><span class="line-number">13</span><br><span class="line-number">14</span><br><span class="line-number">15</span><br><span class="line-number">16</span><br><span class="line-number">17</span><br><span class="line-number">18</span><br><span class="line-number">19</span><br><span class="line-number">20</span><br><span class="line-number">21</span><br><span class="line-number">22</span><br><span class="line-number">23</span><br><span class="line-number">24</span><br><span class="line-number">25</span><br><span class="line-number">26</span><br><span class="line-number">27</span><br><span class="line-number">28</span><br><span class="line-number">29</span><br><span class="line-number">30</span><br><span class="line-number">31</span><br><span class="line-number">32</span><br><span class="line-number">33</span><br>
</div>
</div>
<h2 id="路由动态component引入"> 路由动态<code>component</code>引入</h2> <div class="language-js line-numbers-mode">
<pre class="language-js"><code><span class="token keyword">export</span> <span class="token keyword">const</span> <span class="token function-variable function">loadView</span> <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token parameter">view</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
<span class="token comment">// 路由懒加载</span>
<span class="token keyword">return</span> <span class="token punctuation">(</span><span class="token parameter">resolve</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">@/views/</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${</span>view<span class="token interpolation-punctuation punctuation">}</span></span><span class="token template-punctuation string">`</span></span><span class="token punctuation">]</span><span class="token punctuation">,</span> resolve<span class="token punctuation">)</span>
<span class="token punctuation">}</span>
</code></pre> <div class="line-numbers-wrapper">
<span class="line-number">1</span><br><span class="line-number">2</span><br><span class="line-number">3</span><br><span class="line-number">4</span><br>
</div>
</div>
<h2 id="遇到的坑"> 遇到的坑</h2> <p>1、在<code>vue-route:3x</code>版本内，废弃了<code>router.addRoutes</code>,而是使用<code>router.addRoute</code>,注意没有<code>s</code>
2、<code>router.getRoutes</code>获取的路由层级只有一层！不会出现子路由，子路由会有<code>parent</code>属性。
3、永远不要使用<code>this.$router.options.routes</code>来获取路由，因为动态修改路由这里面不会变化，真的是坑啊！！
4、路由f5刷新后,之前动态添加的路由都会丢失。。
5、404页面，钩子函数内进行判断就好。 不要写这句 <code>{ path: '*', redirect: '/404' }</code></p> <p><a href="https://github.com/vuejs/vue-router/issues/1859" target="_blank" rel="noopener noreferrer">可以参考花裤衩大佬的提问<span> </span></a></p> <h2 id="写在最后"> 写在最后</h2> <ul>
<li>代码内可能有Bug，希望可以在仓库<a href="https://github.com/zhoufanglu/dynamic-vue-router" target="_blank" rel="noopener noreferrer">issues<span> </span></a>提出</li> <li>在<code>beforeEach</code>判断是否为动态路由那是否有更好的解决方式？</li> <li><a href="https://github.com/zhoufanglu/dynamic-vue-router" target="_blank" rel="noopener noreferrer">代码地址<span> </span></a></li> <li>感谢阅读✿</li>
</ul>
