<%--
  Created by IntelliJ IDEA.
  User: 24881
  Date: 2024/10/31
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程实验页面</title>
    <link rel="icon" href="img/favicon.ico">
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-plus/dist/index.css">
    <script src="https://unpkg.com/element-plus"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div id="workTest">
    <p style="width: 100%;text-align: center;font-size: 25px;">用户登录</p>
    <el-form ref="ruleFormRef" :model="loginUser" status-icon :rules="rules" label-width="auto"
             class="demo-ruleForm"
             style="width: 100%;display: flex;flex-direction: column; justify-content: center;align-items: center"
             label-position="top" size="large">
        <el-form-item label="账号" prop="account" style="width: 80%">
            <el-input v-model.trim.number="loginUser.account" type="text" placeholder="请输入账号"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password" style="width: 80%">
            <el-input v-model.trim="loginUser.password" type="password" placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item style="margin-top: 5%;">
            <el-button type="primary" @click="loginSubmit">登录</el-button>
        </el-form-item>
    </el-form>
    <p style="width: 100%;text-align: center;font-size: 25px;">图片上传</p>
    <el-upload action="file/upload" class="upload-demo" :on-success="SuccessUpload"
               :show-file-list="false" name="upload">
        <el-button size="large" type="success">上传图片</el-button>
    </el-upload>
    <el-image style="width: 50%; height: 400px" :src="url" fit="fill"></el-image>
</div>




</body>
<script type="module">
    Vue.createApp({
        data() {
            return {
                loginUser: {
                    account: '',
                    password: '',
                },
                rules: {
                    account: [
                        {required: true, message: '请输入账号', trigger: 'blur'},
                        {type: 'number', message: '请输入正确的账号', trigger: ['blur', 'change']},
                    ],
                    password: [
                        {required: true, message: '请输入密码', trigger: 'blur'},
                        {min: 8, message: '密码至少8位数字或字母', trigger: 'blur'},
                        {max: 20, message: '密码最多20位数字或字母', trigger: 'blur'},
                        {
                            pattern: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{8,20}$/,
                            message: '密码必须同时包含数字和字母',
                            trigger: 'blur'
                        },
                    ],
                },
                url:'http://localhost:8083/file/download_1',
            }
        },
        methods: {
            loginSubmit() {
                if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{8,20}$/.test(this.loginUser.password)) {
                    window.alert('密码输入错误')
                    return
                }
                let temp = new FormData()
                temp.set('user.account', this.loginUser.account)
                temp.set('user.password', this.loginUser.password)
                axios.post('user/login', temp).then((response) => {
                    if (response.data.code === 1) {
                        window.alert('登录成功')
                    } else window.alert(response.data.msg)
                })
            },
            SuccessUpload(res){
                console.log(this.url)
                this.url='http://localhost:8083/file/download_'+res.data
                console.log(this.url)
            },
        },
    }).use(ElementPlus).mount('#workTest')
</script>
</html>
