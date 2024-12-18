<%--
  Created by IntelliJ IDEA.
  User: 24881
  Date: 2024/10/27
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <link rel="icon" href="img/favicon.ico">
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-plus/dist/index.css">
    <script src="https://unpkg.com/element-plus"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div class="place">
    <div id="register">
        <p style="width: 100%;text-align: center;font-size: 25px;">用户注册</p>
        <el-form ref="ruleFormRef" :model="regUser" status-icon :rules="rules" label-width="auto" class="demo-ruleForm"
                 style="width: 100%;display: flex;flex-direction: column; justify-content: center;align-items: center;"
                 size="large" label-position="top"
                 class="demo-ruleForm">
            <el-form-item label="账号" prop="account" style="width: 80%">
                <el-input v-model.trim.number="regUser.account" type="text" placeholder="请输入账号"></el-input>
            </el-form-item>

            <el-form-item label="密码" prop="password" style="width: 80%">
                <el-input v-model.trim="regUser.password" type="password"
                          placeholder="请输入密码(包含字母和数字的8-20位密码)"></el-input>
            </el-form-item>

<%--            <el-form-item label="手机号" prop="phone" style="width: 80%">--%>
<%--                <el-input v-model.trim.number="regUser.phone" type="text" placeholder="请输入手机号"></el-input>--%>
<%--            </el-form-item>--%>
<%--            <el-form-item label="电子邮件" prop="email" style="width: 80%">--%>
<%--                <el-input v-model.trim="regUser.email" type="text" placeholder="请输入邮箱地址"></el-input>--%>
<%--            </el-form-item>--%>
            <el-form-item style="margin-top: 5%;">
                <el-button type="primary" @click="registerSubmit">注册</el-button>
            </el-form-item>
        </el-form>
        <a href="login.jsp" style="width: 100%;text-align: center;font-size: 15px;">用户登录</a>
    </div>
</div>
</body>
<script type="module">
    Vue.createApp({
        data() {
            return {
                regUser: {
                    account: '',
                    password: '',
                    // phone: '',
                    // email: ''

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
                    // phone: [
                    //     {pattern: /^1[3,4,5,7,8][0-9]{9}$/, message: '请输入正确的手机号', trigger: ['blur', 'change']},
                    //     {required: true, message: '请输入手机号', trigger: 'blur'},
                    // ],
                    // email: [
                    //     {required: true, message: '请输入手机号', trigger: 'blur'},
                    //     {
                    //         pattern: /^([A-Za-z0-9_\-.])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,4})$/,
                    //         message: "请输入正确的电子邮箱",
                    //         trigger: ['blur', 'change']
                    //     }
                    // ]
                }
            }
        },
        methods: {
            registerSubmit() {
                if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{8,20}$/.test(this.regUser.password)) {
                    window.alert('请输入符合规则的密码')
                    return;
                }
                // if (!/^1[3,4,5,7,8][0-9]{9}$/.hibernateEntity(this.regUser.phone)){
                //     window.alert('请输入正确的手机号')
                //     return;
                // }
                // if(!/^([A-Za-z0-9_\-.])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,4})$/.hibernateEntity(this.regUser.email)){
                //     window.alert('请输入正确的邮箱地址')
                //     return;
                // }
                let temp=new FormData()
                temp.set('user.account',this.regUser.account)
                temp.set('user.password',this.regUser.password)
                axios.post('user/register', temp).then((response)=>{
                    if(response.data.code===1){
                        window.alert('注册成功，点击返回登录页面')
                        location.href='login.jsp'
                        return;
                    }
                    window.alert(response.data.msg);
                })
            }
        }
    }).use(ElementPlus).mount('#register')
</script>
<style>
    .place {
        height: 100%;
        width: 100%;
        position: absolute;
        top: 0;
        left: 0;
        background-image: url("img/荀攸.png");
        background-size: cover;
    }

    #register {
        height: 50%;
        width: 30%;
        position: absolute;
        top: 25%;
        right: 35%;
        opacity: 0.8;
        display: flex;
        border: 4px solid rgb(200, 255, 255);
        background-color: aqua;
        border-radius: 40px;
        box-shadow: 0 0 50px black;
        justify-content: center;
        flex-direction: column;
    }
</style>
</html>
