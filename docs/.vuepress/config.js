const nav = require("./nav.js"); // 引入刚刚生成的文件
module.exports = {
  title: 'lufangzhou',
  description: '记录平凡的代码人生',
  base: '/vuepressBlog/',
  theme: 'reco',
  head: [
    ['link', {rel: 'icon', href: '/img/favicon.ico'}],
    /*['script', {type: 'text/javascript', src: 'https://cdn.jsdelivr.net/gh/bmob/hydrogen-js-sdk@2.2.3/dist/Bmob-2.2.3.min.js'}]*/
  ],
  markdown: {
    lineNumbers: true // 代码块显示行号
  },
  plugins: [
    [require('./plugins/vuepress-plugin-sakana'), {
      scale: .5
    }],
    // 全局组件
    /*['@vuepress/register-components', {
      // componentsDir: './components'
/!*
      components: [
        {
          name: 'p-test',
          path: './components/test.vue'
        }
      ]
*!/
    }],*/
    [
      '@vuepress/last-updated',
      {
        transformer: (timestamp, lang) => {
          // 不要忘了安装 moment
          // moment 时间格式化文档戳这里 http://momentjs.cn/
          const moment = require('moment')
          moment.locale(lang)
          return moment(timestamp).fromNow()
        }
      }
    ],
    //https://shanyuhai123.github.io/vuepress-plugin-auto-sidebar/features/plugin-options.html
    /*["vuepress-plugin-auto-sidebar", {
      nav: true, //自动生成顶部nav  这里没用
      collapsable: true,
      sort: 'asc',
      titleMap: {//标题映射
        "框架": "🎉 框架 🎉",
        "语言": "🎉 语言🎉 ",
        "阅读": "🎉 阅读🎉 ",
        "javascript": "🎉 javascript🎉 ",
        "随笔": "🎉 随笔🎉 ",
      }
    },],*/
    ['@vuepress/search', {
      searchMaxSuggestions: 5
    }],
    //彩带
    ["ribbon-animation", {
      size: 90,   // 默认数据
      opacity: 0.3,  //  透明度
      zIndex: -1,   //  层级
      opt: {
        // 色带HSL饱和度
        colorSaturation: "80%",
        // 色带HSL亮度量
        colorBrightness: "60%",
        // 带状颜色不透明度
        colorAlpha: 0.65,
        // 在HSL颜色空间中循环显示颜色的速度有多快
        colorCycleSpeed: 6,
        // 从哪一侧开始Y轴 (top|min, middle|center, bottom|max, random)
        verticalPosition: "center",
        // 到达屏幕另一侧的速度有多快
        horizontalSpeed: 200,
        // 在任何给定时间，屏幕上会保留多少条带
        ribbonCount: 2,
        // 添加笔划以及色带填充颜色
        strokeSize: 0,
        // 通过页面滚动上的因子垂直移动色带
        parallaxAmount: -0.5,
        // 随着时间的推移，为每个功能区添加动画效果
        animateSections: true
      },
      ribbonShow: false, //  点击彩带  true显示  false为不显示
      ribbonAnimationShow: true  // 滑动彩带
    }],
    // 代码复制弹窗插件
    ["vuepress-plugin-nuggets-style-copy", {
      copyText: "复制代码",
      tip: {
        content: "复制成功!"
      }
    }],
    // 音乐插件
    ['meting', {
      //metingApi: "https://meting.sigure.xyz/api/music",
      meting: {
        // 网易
        auto: "http://music.163.com/#/song?id=29572578",
      },
      // 不配置该项的话不会出现全局播放器
      aplayer: {
        // 吸底模式
        fixed: true,
        mini: true,
        // 自动播放
        autoplay: true,
        // 歌曲栏折叠
        listFolded:true,
        // 颜色
        theme: '#ffffff',
        // 播放顺序为随机
        order: 'random',
        // 初始音量
        volume: 0.5,
        // 关闭歌词显示
        lrcType: 0
      },
      mobile :{
        // 手机端去掉cover图
        cover: false,
      }
    }],
    //樱花特效
    /*["sakura", {
      num: 20,  // 默认数量
      show: true, //  是否显示
      zIndex: -1,   // 层级
      img: {
        replace: false,  // false 默认图 true 换图 需要填写httpUrl地址
        httpUrl: '...'     // 绝对路径
      }
    }]*/
    /*[
      'vuepress-plugin-rss',
      {
        base_url: '/', // required
        site_url: 'https://an9wer.github.io/blog.html', // required
        copyright: '2018 Young Tailors', // optional
        // filter some post
        filter: (frontmatter) => { return true },
        // How much articles
        count: 20
      }
    ]*/
    /*["vuepress-plugin-live2d", { //z16，Epsilon2.1，izumi，koharu，shizuku，miku, hijiki, tororo
      "modelName": "shizuku", //https://huaji8.top/post/live2d-plugin-2.0/
      "mobileShow": false
    },]*/
  ],
  configureWebpack: {
    resolve: {
      alias: {
        '@imgSrc': 'docs/.vuepress/public/img'
      }
    }
  },
  themeConfig: {
    type: 'blog',
    authorAvatar: '/img/headimg.jpg',
    mode: 'dark', // 默认 auto，auto 跟随系统，dark 暗色模式，light 亮色模式
    logo: '/img/headimg.jpg',
    //sidebarDepth: 3, // e'b将同时提取markdown中h2 和 h3 标题，显示在侧边栏上。
    lastUpdated: '上次更新', // 文档更新时间：每个文件git最后提交的时间
    displayAllHeaders: false, // 默认值：false 设置为true来显示所有页面的标题链接：
    subSidebar: 'auto',//在所有页面中启用自动生成子侧边栏，原 sidebar 仍然兼容
    /*algolia: {
      apiKey: '<API_KEY>',
      indexName: '<INDEX_NAME>'
    },*/
    //nav,
    nav: [
      {text: '首页', link: '/'},
      {
        text: '笔记',
        items: [
          {text: '语言', link: '/语言/'},
          {text: '框架', link: '/框架/'},
          {text: '阅读', link: '/阅读/'},
          {text: 'hexo迁移', link: '/hexo迁移/'},
          {text: '随笔', link: '/随笔/'},
        ],
      },
      {
        text: '个人主页',
        items: [
          {text: '掘金', link: 'https://juejin.im/user/5afd39c36fb9a07ac162a318'},
          {text: 'GitHub', link: 'https://github.com/zhoufanglu'},
          {text: 'hexo', link: 'https://zhoufanglu.github.io/'},
        ]
      },
      { text: 'TimeLine', link: '/timeline/', icon: 'reco-date' }
    ],
    // 博客配置
    blogConfig: {
      category: {
        location: 2,     // 在导航栏菜单中所占的位置，默认2
        text: '分类' // 默认文案 “分类”
      },
      tag: {
        location: 3,     // 在导航栏菜单中所占的位置，默认3
        text: '标签'      // 默认文案 “标签”
      },
    },
    /**********************评论功能***********************/
    valineConfig: {
      appId: 'jLNreXM5OXluMGHeuoPSCQAa-gzGzoHsz',// your appId
      appKey: 'YM83RgrLTH5ukEzLbseTjNL5', // your appKey
      showComment: true
    },
    vssueConfig: {
      platform: 'github',
      owner: 'OWNER_OF_REPO',
      repo: 'NAME_OF_REPO',
      clientId: 'YOUR_CLIENT_ID',
      clientSecret: 'YOUR_CLIENT_SECRET',
    },
    friendLink: [
      {
        title: 'an9wer',
        logo: "/img/headImg/wuXinRun.png",
        link: 'https://an9wer.github.io/blog.html'
      },
      {
        title: 'wanger',
        logo: "/img/headImg/wangYuLue.png",
        //email: 'recoluan@qq.com',
        link: 'https://wangyulue.com/'
      },
      {
        title: '饭团也有春天',
        link: 'http://www.zpzpup.com/blog/'
      },
      {
        title: 'Chereby',
        link: 'http://www.chereby.com/'
      },
    ]
    /*sidebar: {
      '/code/': [
        ['/code/javascript/对象操作.md', '对象操作'],
        ['/code/javascript/深浅拷贝.md', '深浅拷贝'],
      ]
    }*/
  },
}
