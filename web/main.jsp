<%--
  Created by IntelliJ IDEA.
  User: 24881
  Date: 2024/10/29
  Time: 13:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页面</title>
    <link rel="icon" href="img/favicon.ico">
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-plus/dist/index.css">
    <script src="https://unpkg.com/element-plus"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="//unpkg.com/@element-plus/icons-vue"></script>
</head>
<body>
<div class="place" id="place">
    <el-container>
        <el-header
                style="width: 100%;height: 15%;background-color: lightblue;position: absolute;top: 0;left: 0;display: flex;align-items: center;padding: 0">
            <el-menu class="el-menu-demo" mode="horizontal" :ellipsis="false">
                <el-menu-item index="0" style="width: 25%;display: flex;align-items: center"><!--项目图片和返回主页按钮-->
                    <img src="img/logo.svg" alt="Element logo" style="transform: skew(-20deg);"/>
                    <p>图书管理系统</p>
                </el-menu-item>
                <el-sub-menu index="1" style="margin-right: 7%;width: 10%;"><!--个人账户信息-->
                    <template #title>
                        <div class="block">
                            <el-avatar :size="50"
                                       :src="'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'"></el-avatar>
                        </div>
                        <p style="font-family: none;font-style: normal;font-size: 30px;">账号</p>
                    </template>
                    <el-menu-item index="1-1" style="font-size: 20px;" @click="MyInfo">个人信息</el-menu-item>
                    <el-menu-item index="1-2" style="font-size: 20px;" @click="changeSymbol = true">切换账号
                    </el-menu-item>
                    <el-menu-item index="1-3" style="font-size: 20px;" @click="LogOut()">退出登录</el-menu-item>
                </el-sub-menu>
            </el-menu>
        </el-header>
        <el-main
                style="width: 98%;height: 82%;background-color: aqua;position: absolute;bottom: 1.5%;left: 1%;box-shadow: 0 0 10px black;padding: 0;
                border-radius: 50px">
            <div style="height: 100%;width: 100%;display: flex">
                <div style="width: 61.8%;height: 100%;border-right: black 2px dashed">
                    <el-tabs type="card" v-model="activeNameList" @tab-change="test"
                             style="width: 99%;height: 99%;margin-left: 1%">
                        <el-tab-pane label="书籍列表" name="bookList">
                            <div style="width: 100%;height: 100%;border-bottom-left-radius: 50px;border-top-left-radius: 50px;">
                                <div style="width: 80%;height: 8%;display: flex;align-items: center">
                                    <el-dropdown @command="searchWayChange" style="margin: 0 5%">
                                        <span class="el-dropdown-link">
<%--                                            选择搜索方式--%>
                                            {{searchWayMsg}}
                                            <el-icon class="el-icon--right"><svg xmlns="http://www.w3.org/2000/svg"
                                                                                 viewBox="0 0 1024 1024"><path
                                                    fill="currentColor"
                                                    d="M831.872 340.864 512 652.672 192.128 340.864a30.592 30.592 0 0 0-42.752 0 29.12 29.12 0 0 0 0 41.6L489.664 714.24a32 32 0 0 0 44.672 0l340.288-331.712a29.12 29.12 0 0 0 0-41.728 30.592 30.592 0 0 0-42.752 0z"></path></svg></el-icon>
                                        </span>
                                        <template #dropdown>
                                            <el-dropdown-menu>
                                                <el-dropdown-item command="book1">书籍号查询</el-dropdown-item>
                                                <el-dropdown-item command="book2">书名查询</el-dropdown-item>
                                                <el-dropdown-item command="book3">作者查询</el-dropdown-item>
                                                <el-dropdown-item command="book4">出版社查询</el-dropdown-item>
                                            </el-dropdown-menu>
                                        </template>
                                    </el-dropdown>
                                    <el-input v-model.trim="search" size="small" :placeholder="searchWayMsg"
                                              style="width: 50%;" @input="searchMethod"></el-input>
                                </div>
                                <el-table border stripe :data="filterBookList"
                                          style="width: 100%;height: 92%;" ref="selectionStudents"
                                          :row-style="{ height: '49px' }"
                                ><!-- 表格内容-->
                                    <el-table-column prop="index" label="书籍号" width="120"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column prop="name" label="书籍名" width="150"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column prop="author" label="作者" width="150"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column prop="pubhos" label="出版社" width="170"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column align="right">
                                        <template #default="scope">
                                            <el-button size="small" @click="checkBookSpInfo(scope.row)">查看书籍信息
                                            </el-button>
                                            <el-button v-if="userType" size="small" @click="changeBookInfo(scope.row)"
                                                       type="primary">修改书籍信息
                                            </el-button>
                                            <el-button size="small" type="primary"
                                                       @click="deleteBook(scope.row)">删除书籍
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="我的借阅" name="MyBorrow" v-if="!userType">
                            <div style="width: 100%;height: 100%;border-bottom-left-radius: 50px;border-top-left-radius: 50px">
                                <div style="width: 80%;height: 8%;display: flex;align-items: center">
                                    <el-dropdown @command="searchWayChange" style="margin: 0 5%">
                                        <span class="el-dropdown-link">
<%--                                            选择搜索方式--%>
                                            {{searchWayMsg}}
                                            <el-icon class="el-icon--right"><svg xmlns="http://www.w3.org/2000/svg"
                                                                                 viewBox="0 0 1024 1024"><path
                                                    fill="currentColor"
                                                    d="M831.872 340.864 512 652.672 192.128 340.864a30.592 30.592 0 0 0-42.752 0 29.12 29.12 0 0 0 0 41.6L489.664 714.24a32 32 0 0 0 44.672 0l340.288-331.712a29.12 29.12 0 0 0 0-41.728 30.592 30.592 0 0 0-42.752 0z"></path></svg></el-icon>
                                        </span>
                                        <template #dropdown>
                                            <el-dropdown-menu>
                                                <el-dropdown-item command="myBorrow1">书籍号查询</el-dropdown-item>
                                                <el-dropdown-item command="myBorrow2">书名查询</el-dropdown-item>
                                                <el-dropdown-item command="myBorrow3">作者查询</el-dropdown-item>
                                                <el-dropdown-item command="myBorrow4">出版社查询</el-dropdown-item>
                                            </el-dropdown-menu>
                                        </template>
                                    </el-dropdown>
                                    <el-input v-model.trim="search" size="small" :placeholder="searchWayMsg"
                                              style="width: 50%;" @input="searchMethod"></el-input>
                                </div>
                                <el-table border stripe :data="filterMyBorrowList"
                                          style="width: 100%;height: 92%;" ref="selectionStudents"
                                          :row-style="{ height: '49px' }"
                                ><!-- 表格内容-->
                                    <el-table-column prop="index" label="书籍号" width="120"
                                                     sortable></el-table-column>
                                    <el-table-column prop="name" label="书籍名" width="150"
                                                     sortable></el-table-column>
                                    <el-table-column prop="author" label="作者" width="120"
                                                     sortable></el-table-column>
                                    <el-table-column prop="pubhos" label="出版社" width="170"
                                                     sortable></el-table-column>
                                    <el-table-column align="right">
                                        <template #default="scope">
                                            <el-button size="small" @click="checkBookSpInfo(scope.row)">查看书籍信息
                                            </el-button>
                                            <el-button size="small" type="primary"
                                                       @click="returnBook(scope.row)">归还书籍
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="借阅情况" name="Borrow" v-if="userType">
                            <div style="width: 100%;height: 100%;border-bottom-left-radius: 50px;border-top-left-radius: 50px">
                                <el-table border stripe :data="BorrowList"
                                          style="width: 100%;height: 100%;" ref="selectionStudents"
                                          :row-style="{ height: '49px' }"
                                ><!-- 表格内容-->
                                    <el-table-column prop="bookIndex" label="书籍号" width="120"
                                                     sortable></el-table-column>
                                    <el-table-column prop="readerIndex" label="读者编号" width="150"
                                                     sortable></el-table-column>
                                    <el-table-column prop="begin" label="借阅时间" width="150"
                                                     sortable></el-table-column>
                                    <el-table-column prop="end" label="预计归还时间" width="150"
                                                     sortable></el-table-column>
                                    <el-table-column align="center">
                                        <template #default="scope">
                                            <el-button size="small" type="primary"
                                                       @click="returnBookTwo(scope.row)">归还书籍
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="用户列表" name="userList" v-if="userType">
                            <div style="width: 100%;height: 100%;border-bottom-left-radius: 50px;border-top-left-radius: 50px">
                                <div style="width: 80%;height: 8%;display: flex;align-items: center">
                                    <el-dropdown @command="searchWayChange" style="margin: 0 5%">
                                        <span class="el-dropdown-link">
                                            {{searchWayMsg}}
                                            <el-icon class="el-icon--right"><svg xmlns="http://www.w3.org/2000/svg"
                                                                                 viewBox="0 0 1024 1024"><path
                                                    fill="currentColor"
                                                    d="M831.872 340.864 512 652.672 192.128 340.864a30.592 30.592 0 0 0-42.752 0 29.12 29.12 0 0 0 0 41.6L489.664 714.24a32 32 0 0 0 44.672 0l340.288-331.712a29.12 29.12 0 0 0 0-41.728 30.592 30.592 0 0 0-42.752 0z"></path></svg></el-icon>
                                        </span>
                                        <template #dropdown>
                                            <el-dropdown-menu>
                                                <el-dropdown-item command="reader1">账号查询</el-dropdown-item>
                                                <el-dropdown-item command="reader2">姓名查询</el-dropdown-item>
                                                <el-dropdown-item command="reader3">手机号查询</el-dropdown-item>
                                                <el-dropdown-item command="reader4">邮件查询</el-dropdown-item>
                                            </el-dropdown-menu>
                                        </template>
                                    </el-dropdown>
                                    <el-input v-model.trim="search" size="small" :placeholder="searchWayMsg"
                                              style="width: 50%;" @input="searchMethod"></el-input>
                                </div>
                                <el-table border stripe :data="filterReaderList"
                                          style="width: 100%;height: 92%;" ref="selectionStudents"
                                          :row-style="{ height: '49px' }"
                                ><!-- 表格内容-->
                                    <el-table-column prop="account" label="账号" width="120"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column prop="name" label="姓名" width="150"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column prop="phone" label="手机号" width="120"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column prop="email" label="电子邮件" width="170"
                                                     sortable :show-overflow-tooltip="true"></el-table-column>
                                    <el-table-column align="right">
                                        <template #default="scope">
                                            <el-button size="small" @click="checkReaderSpInfo(scope.row)">查看用户信息
                                            </el-button>
                                            <el-button size="small" type="danger"
                                                       @click="deleteReader(scope.row)">删除用户
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </el-tab-pane>
                    </el-tabs>
                </div>
                <div style="width: 38.2%;height: 100%;background-color: white;border-left: black 2px dashed">
                    <el-tabs type="card" v-model="activeName" @tab-remove="removeTab"
                             style="width: 99%;height: 99%;">
                        <el-tab-pane label="可借阅书籍" v-if="!userType" name="borrowBook">
                            <div style="width: 100%;height: 100%;background-color: antiquewhite;border-bottom-right-radius: 50px;border-top-right-radius: 50px">
                                <div style="width: 80%;height: 8%;display: flex;align-items: center">
                                    <el-input v-model.trim="borrowSearch" size="small" placeholder="输入书籍号搜索书籍"
                                              style="width: 50%;" @input="borrowSearchMethod"></el-input>
                                </div>
                                <el-table border stripe :data="filterAvailableForBorrow"
                                          style="width: 100%;height: 92%;" ref="selectionStudents"
                                          :row-style="{ height: '49px' }"
                                ><!-- 表格内容-->
                                    <el-table-column prop="index" label="书籍号" width="120"
                                                     sortable></el-table-column>
                                    <el-table-column prop="name" label="书籍名" width="150"
                                                     sortable></el-table-column>
                                    <el-table-column prop="author" label="作者" width="120"
                                                     sortable></el-table-column>
                                    <el-table-column prop="pubhos" label="出版社" width="170"
                                                     sortable></el-table-column>
                                    <el-table-column align="right">
                                        <template #header>书籍操作</template>
                                        <template #default="scope">
                                            <el-button size="small" @click="borrowBook(scope.row)" type="primary">借阅
                                            </el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="添加或修改书籍信息" name="newBook" v-if="userType">
                            <div style="width: 100%;height: 100%;border-bottom-right-radius: 50px;border-top-right-radius: 50px;display: flex">
                                <el-form style="width: 100%;display: flex;flex-wrap: wrap; justify-content: center;"
                                         :model="newBook"
                                         status-icon label-width="auto" class="demo-ruleForm" label-position="top"
                                         size="default" ref="NewStudentRef"
                                         :rules="newBookRules">

                                    <el-form-item label="书籍名" prop="studentNo" style="width: 80%">
                                        <el-input v-model.trim.number="newBook.name" type="text"></el-input>
                                    </el-form-item>

                                    <el-form-item label="作者" prop="studentName" style="width: 80%">
                                        <el-input v-model.trim="newBook.author" type="text"></el-input>
                                    </el-form-item>

                                    <el-form-item label="出版社" prop="studentSex" style="width: 80%">
                                        <el-input v-model.trim="newBook.pubhos" type="text"></el-input>
                                    </el-form-item>

                                    <el-form-item label="简介" prop="admissionGrades" style="width: 80%">
                                        <el-input v-model="newBook.summary" type="text"></el-input>
                                    </el-form-item>

                                    <el-form-item label="价格" prop="systemNo" style="width: 80%">
                                        <el-input v-model.trim="newBook.price" type="text"></el-input>
                                    </el-form-item>

                                    <el-form-item label="上传封面" style="width: 80%;">
                                        <el-upload action="file/upload" class="upload-demo" name="upload"
                                                   :on-success="SuccessStudentUpload">
                                            <el-button type="primary">选择图片</el-button>
                                        </el-upload>
                                    </el-form-item>

                                    <el-form-item style="width: 80%;">
                                        <el-button @click="resetNewBookForm">重置</el-button>
                                        <el-button type="primary" @click="insertNewBook">确定</el-button>
                                    </el-form-item>
                                </el-form>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="书籍信息" name="bookSpInfo" v-if="bookSpInfoHidden" closable>
                            <div style="width: 100%;height: 100%;background-color: darkcyan;border-bottom-right-radius: 50px;border-top-right-radius: 50px">
                                <div style="width: 100%;height: 100%;display: flex;flex-wrap: wrap">
                                    <el-image style="width: 50%;height: 70%"
                                              :src="'http://localhost:8083/file/download_'+rightBookInfo.flag"
                                              fit="fill"></el-image>
                                    <div style="width: 50%;height: 70%;display: flex;flex-direction: column;justify-content: space-around">
                                        <span>书籍编号：{{rightBookInfo.index}}</span>
                                        <span>书籍名：{{rightBookInfo.name}}</span>
                                        <span>书籍作者：{{rightBookInfo.author}}</span>
                                        <span>书籍出版社：{{rightBookInfo.pubhos}}</span>
                                        <span>书籍价格：{{rightBookInfo.price}}</span>
                                    </div>
                                    <div style="width: 100%;height: 50%;font-size: 20px">
                                        <span>书籍简介：{{rightBookInfo.summary}}</span>
                                    </div>
                                </div>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="个人信息" name="userSpInfo" v-if="userSpInfoHidden" closable>
                            <div style="width: 100%;height: 100%;background-color: deepskyblue;border-bottom-right-radius: 50px;border-top-right-radius: 50px">
                                <div style="width: 100%;height: 100%;display: flex;flex-direction: column">
                                    <el-image style="width: 100%;height: 60%"
                                              :src="'http://localhost:8083/file/download_'+rightReaderInfo.flag"
                                              fit="cover"></el-image>
                                    <div style="width: 100%;height: 40%;display: flex;flex-direction: column;justify-content: space-around">
                                        <el-button @click="updataReaderSymbol=true" style="width: 20%">修改用户信息</el-button>
                                        <span>读者账号：{{rightReaderInfo.account}}</span>
                                        <span>读者姓名：{{rightReaderInfo.name}}</span>
                                        <span>读者手机号：{{rightReaderInfo.phone}}</span>
                                        <span>读者邮件：{{rightReaderInfo.email}}</span>
                                    </div>
                                </div>
                            </div>
                        </el-tab-pane>
                    </el-tabs>
                </div>
            </div>
        </el-main>
    </el-container>
    <div>
        <el-dialog v-model="changeSymbol" title="Shipping address" width="500">
            <el-form :model="loginUser" ref="accountFormRef" :rules="userRules">
                <el-form-item label="账号" label-width="50px">
                    <el-input v-model.trim="loginUser.account" type="text"></el-input>
                </el-form-item>
                <el-form-item label="密码" label-width="50px">
                    <el-input type="password" v-model.trim="loginUser.password"></el-input>
                </el-form-item>
            </el-form>
            <template #footer>
                <div class="dialog-footer">
                    <el-button @click="cancelLog">取消</el-button>
                    <el-button type="primary" @click="changeAccount">
                        确定
                    </el-button>
                </div>
            </template>
        </el-dialog>
        <el-dialog v-model="updataReaderSymbol" title="Shipping address" width="500">
            <el-form :model="updataNewReader" ref="accountFormRef" :rules="userRules">
                <el-form-item label="姓名" label-width="50px">
                    <el-input v-model.trim="updataNewReader.name" type="text"></el-input>
                </el-form-item>
                <el-form-item label="手机号" label-width="50px">
                    <el-input type="password" v-model.trim="updataNewReader.phone"></el-input>
                </el-form-item>
                <el-form-item label="邮件" label-width="50px">
                    <el-input type="password" v-model.trim="updataNewReader.email"></el-input>
                </el-form-item>
                <el-form-item label="上传图片" label-width="50px">
                    <el-upload action="file/upload" class="upload-demo" name="upload"
                               :on-success="SuccessReaderUpload">
                        <el-button type="primary">选择图片</el-button>
                    </el-upload>
                </el-form-item>
            </el-form>
            <template #footer>
                <div class="dialog-footer">
                    <el-button @click="cancelUpdata">取消</el-button>
                    <el-button type="primary" @click="updataReader">
                        确定
                    </el-button>
                </div>
            </template>
        </el-dialog>
    </div>
</div>
</body>

<script type="module">
    Vue.createApp({
        data() {
            return {
                updataSym: false,
                activeName: 'none',//此时选择的标签页（右侧）
                activeNameList: 'none',//选择的标签页（左侧）
                bookSpInfoHidden: false,//实际简介标签页是否显示
                userSpInfoHidden: false,//用户个人信息标签页是否显示
                userType: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')).type === '0' : false,//判断用户类型，开放相应的权限
                changeSymbol: false,//切换账号页面是否显示
                search: '',//搜索内容（左侧）
                searchWayMsg: '请先选择搜索方式',//搜索框中的提示信息
                borrowSearch: '',//搜索内容（右侧）
                searchWay: '',//搜索方式（左侧）
                userRules: {
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
                },//用户登录检测
                bookList: [{
                    index: '',
                    name: '',
                    author: '',
                    pubhos: '',
                }],//原始书籍列表
                filterBookList: this.bookList,//经过处理的书籍列表
                myBorrowList: [{
                    index: '',
                    name: '',
                    author: '',
                    pubhos: '',
                }],//原始借阅书籍列表
                filterMyBorrowList: this.myBorrowList,//处理后的借阅书籍列表
                readerList: [{
                    account: '',
                    name: '',
                    phone: '',
                    email: '',
                }],//原始读者列表
                filterReaderList: this.readerList,//处理后的读者列表
                availableForBorrow: [{
                    index: '',
                    name: '',
                    author: '',
                    pubhos: '',
                }],//原始可借阅书籍列表
                filterAvailableForBorrow: this.availableForBorrow,//处理后的可借阅书籍列表
                loginUser: {
                    account: '',
                    password: '',
                },//切换账号的的账号信息
                newBook: {
                    name: '',
                    author: '',
                    pubhos: '',
                    summary: '',
                    flag: '',
                    price: ''
                },//添加新书时的信息
                newBookRules: {
                    name: [
                        {required: true, message: '不能为空', trigger: 'blur'}
                    ],
                    author: [
                        {required: true, message: '不能为空', trigger: 'blur'}
                    ],
                    pubhos: [
                        {required: true, message: '不能为空', trigger: 'blur'}
                    ],
                    summary: [
                        {required: true, message: '不能为空', trigger: 'blur'}
                    ],
                    flag: [
                        {required: true, message: '不能为空', trigger: 'blur'}
                    ],
                    price: [
                        {required: true, message: '不能为空', trigger: 'blur'}
                    ]
                },//添加新书时的限制条件
                rightBookInfo: {},//右侧书籍信息
                rightReaderInfo: {},//右侧读者信息
                updataNewReader:{
                    name:'',
                    phone:'',
                    email: '',
                    flag:'',

                },//修改用户信息
                updataReaderSymbol:false,
                BorrowList:[{
                    bookIndex:'',
                    readerIndex:'',
                    begin:'',
                    end:'',
                }]
            }
        },
        methods: {
            removeTab(targetName) {
                if (targetName === 'bookSpInfo') {
                    this.bookSpInfoHidden = false
                    this.rightBookInfo = {}
                }
                if (targetName === 'userSpInfo') {
                    this.userSpInfoHidden = false
                    this.rightReaderInfo = {}
                }
                this.activeName = 'none'
            },//当标签被移除时的操作
            MyInfo() {
                axios.get('/reader/getReaderByAccount?account='+JSON.parse(localStorage.getItem('user')).account).then(response => {
                    this.rightReaderInfo = response.data.data
                })
                this.userSpInfoHidden = true
                this.activeName = 'userSpInfo'
            },//查看个人信息
            LogOut() {
                localStorage.removeItem('user')
                location.href = 'login.jsp'
            },//退出登录回到登录页面
            cancelLog() {
                this.loginUser.password = ''
                this.loginUser.account = ''
                this.changeSymbol = false
            },//退出切换账号页面
            changeAccount() {
                if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{8,20}$/.test(this.loginUser.password)) {
                    window.alert('密码输入错误')
                    return
                }
                let temp = new FormData()
                temp.set('user.account', this.loginUser.account)
                temp.set('user.password', this.loginUser.password)
                axios.post('user/login', temp).then((response) => {
                    if (response.data.code === 1) {
                        localStorage.setItem("user", JSON.stringify(response.data.data))
                        window.alert('登录成功')
                        location.href = 'main.jsp'
                    } else window.alert(response.data.msg)
                })
            },//切换账号
            searchWayChange(command) {
                this.searchWay = command
                if (/^book[0-9]$/.test(this.searchWay)) {
                    if (this.searchWay.search('1') !== -1) {
                        this.searchWayMsg = '按书籍号查询'
                    } else if (this.searchWay.search('2') !== -1) {
                        this.searchWayMsg = '按书名查询'
                    } else if (this.searchWay.search('3') !== -1) {
                        this.searchWayMsg = '按作者查询'
                    } else if (this.searchWay.search('4') !== -1) {
                        this.searchWayMsg = '按出版社查询'
                    }
                } else if (/^myBorrow[0-9]$/.test(this.searchWay)) {
                    if (this.searchWay.search('1') !== -1) {
                        this.searchWayMsg = '按书籍号查询'
                    } else if (this.searchWay.search('2') !== -1) {
                        this.searchWayMsg = '按书名查询'
                    } else if (this.searchWay.search('3') !== -1) {
                        this.searchWayMsg = '按作者查询'
                    } else if (this.searchWay.search('4') !== -1) {
                        this.searchWayMsg = '按出版社查询'
                    }
                } else if (/^reader[0-9]$/.test(this.searchWay)) {
                    if (this.searchWay.search('1') !== -1) {
                        this.searchWayMsg = '按账号查询'
                    } else if (this.searchWay.search('2') !== -1) {
                        this.searchWayMsg = '按姓名查询'
                    } else if (this.searchWay.search('3') !== -1) {
                        this.searchWayMsg = '按手机号查询'
                    } else if (this.searchWay.search('4') !== -1) {
                        this.searchWayMsg = '按电子邮件查询'
                    }
                }
                console.log(this.searchWayMsg)
            },//当搜索方式改变时的操作
            searchMethod() {
                if (/^book[0-9]$/.test(this.searchWay)) {
                    if (this.search === '') {
                        this.filterBookList = this.bookList
                        return
                    }
                    this.filterBookList = []
                    if (this.searchWay.search('1') !== -1) {
                        console.log(this.searchWay)
                        this.bookList.forEach((book) => {
                            if (book.index.toString().search(this.search) !== -1) {
                                this.filterBookList.push(book)
                            }
                        })
                    } else if (this.searchWay.search('2') !== -1) {
                        this.bookList.forEach((book) => {
                            if (book.name.search(this.search) !== -1) {
                                this.filterBookList.push(book)
                            }
                        })
                    } else if (this.searchWay.search('3') !== -1) {
                        this.bookList.forEach((book, index) => {
                            if (book.author.search(this.search) !== -1) {
                                this.filterBookList.push(book)
                            }
                        })
                    } else if (this.searchWay.search('4') !== -1) {
                        this.bookList.forEach((book, index) => {
                            if (book.pubhos.search(this.search) !== -1) {
                                this.filterBookList.push(book)
                            }
                        })
                    }
                } else if (/^myBorrow[0-9]$/.test(this.searchWay)) {
                    if (this.search === '') {
                        this.filterMyBorrowList = this.myBorrowList
                        return
                    }
                    this.filterMyBorrowList = []
                    if (this.searchWay.search('1') !== -1) {
                        this.myBorrowList.forEach((myBorrow) => {
                            if (myBorrow.index.toString().search(this.search) !== -1) {
                                this.filterMyBorrowList.push(myBorrow)
                            }
                        })
                    } else if (this.searchWay.search('2') !== -1) {
                        this.myBorrowList.forEach((myBorrow) => {
                            if (myBorrow.name.search(this.search) !== -1) {
                                this.filterMyBorrowList.push(myBorrow)
                            }
                        })
                    } else if (this.searchWay.search('3') !== -1) {
                        this.myBorrowList.forEach((myBorrow) => {
                            if (myBorrow.author.search(this.search) !== -1) {
                                this.filterMyBorrowList.push(myBorrow)
                            }
                        })
                    } else if (this.searchWay.search('4') !== -1) {
                        this.myBorrowList.forEach((myBorrow) => {
                            if (myBorrow.pubhos.search(this.search) !== -1) {
                                this.filterMyBorrowList.push(myBorrow)
                            }
                        })
                    }
                } else if (/^reader[0-9]$/.test(this.searchWay)) {
                    if (this.search === '') {
                        this.filterReaderList = this.readerList
                        return
                    }
                    this.filterReaderList = []
                    if (this.searchWay.search('1') !== -1) {
                        this.readerList.forEach((reader) => {
                            if (reader.account.search(this.search) !== -1) {
                                this.filterReaderList.push(reader)
                            }
                        })
                    } else if (this.searchWay.search('2') !== -1) {
                        this.readerList.forEach((reader) => {
                            if (reader.name.search(this.search) !== -1) {
                                this.filterReaderList.push(reader)
                            }
                        })
                    } else if (this.searchWay.search('3') !== -1) {
                        this.readerList.forEach((reader) => {
                            if (reader.phone.toString().search(this.search) !== -1) {
                                this.filterReaderList.push(reader)
                            }
                        })
                    } else if (this.searchWay.search('4') !== -1) {
                        this.readerList.forEach((reader) => {
                            if (reader.email.search(this.search) !== -1) {
                                this.filterReaderList.push(reader)
                            }
                        })
                    }
                }
            },//搜索相应的内容
            borrowSearchMethod() {
                this.filterAvailableForBorrow = []
                this.availableForBorrow.forEach((book) => {
                    if (book.index.toString().search(this.borrowSearch) !== -1) {
                        this.filterAvailableForBorrow.push(book)
                    }
                })
            },//可借阅书籍处的搜索方式
            test(name) {
                this.searchWayMsg = '请先选择搜索方式'
                this.searchWay = ''
            },
            checkBookSpInfo(tempBook) {
                this.rightBookInfo = tempBook
                this.activeName = 'bookSpInfo'
                this.bookSpInfoHidden = true
            },//查看书籍信息
            borrowBook(tempBook) {
                let temp = new FormData()
                temp.set('borrow.bookIndex', tempBook.index)
                temp.set('borrow.readerIndex', JSON.parse(localStorage.getItem('user')).account)
                axios.post('/borrow/borrowNewBook', temp).then(response => {
                    if (response.data.code === 1) {
                        window.alert('借阅成功')
                        location.reload()
                    } else window.alert('借阅失败')
                })
            },//借阅书籍
            changeBookInfo(tempBook) {
                this.updataSym = true
                this.newBook = tempBook
                this.activeName = 'newBook'
            },//修改书籍信息
            deleteBook(tempBook) {
                let temp = new FormData()
                temp.set('index', tempBook.index)
                axios.post('/book/deleteBook', temp).then(response => {
                    if (response.data.code === 1) {
                        window.alert('删除成功')
                        axios.get("/book/getAllBook").then(response => {
                            this.bookList = response.data.data
                            location.reload()
                        })
                    } else {
                        window.alert('删除失败')
                    }
                })
            },//删除书籍
            returnBook(tempBook) {
                let temp = new FormData()
                temp.set('borrow.bookIndex', tempBook.index)
                temp.set('borrow.readerIndex', JSON.parse(localStorage.getItem('user')).account)
                axios.post('/borrow/returnBook', temp).then(response => {
                    if (response.data.code === 1) {
                        window.alert('归还成功')
                        location.reload()
                    } else window.alert('归还失败')
                })
            },//归还书籍
            checkReaderSpInfo(tempReader) {
                this.rightReaderInfo = tempReader
                this.userSpInfoHidden = true
                this.activeName = 'userSpInfo'
            },//查看用户信息
            deleteReader(tempReader) {
                let temp = new FormData()
                temp.set('account', tempReader.account)
                axios.post('/reader/deleteReaderByAccount',temp).then(response => {
                    if (response.data.code === 1) {
                        window.alert('删除成功')
                        location.reload()
                    } else alert('删除失败')
                })
            },//删除用户
            SuccessStudentUpload(res) {
                this.newBook.flag = res.data
            },//成功上传新书图片后的操作
            insertNewBook() {
                let temp = new FormData()
                if (this.newBook.name === '' || this.newBook.author === '' || this.newBook.pubhos === '' || this.newBook.summary === '' || this.newBook.flag === '' || this.newBook.price === '') {
                    alert('请检查是否有信息未填写')
                    return
                }
                temp.set('newBook.name', this.newBook.name)
                temp.set('newBook.author', this.newBook.author)
                temp.set('newBook.pubhos', this.newBook.pubhos)
                temp.set('newBook.summary', this.newBook.summary)
                temp.set('newBook.flag', this.newBook.flag)
                temp.set('newBook.price', this.newBook.price)
                if (this.updataSym) {
                    temp.set('newBook.index',this.newBook.index)
                    axios.post('/book/updateBook', temp).then(response => {
                        if (response.data.code === 1) {
                            window.alert('修改成功')
                            this.updataSym=false
                            location.reload()
                        } else alert('修改失败')
                    })
                } else {
                    axios.post('/book/insertNewBook', temp).then(response => {
                        if (response.data.code === 1) {
                            window.alert('录入成功')
                            location.reload()
                        } else window.alert('录入失败')
                    })
                }
            },//添加新书的操作
            resetNewBookForm() {
                this.updataSym=false
                this.newBook = {
                    name: '',
                    author: '',
                    pubhos: '',
                    summary: '',
                    flag: '',
                    price: ''
                }
            },//重置新书表格中的信息
            SuccessReaderUpload(res){
                this.updataNewReader.flag=res.data
            },
            cancelUpdata(){
                this.updataReaderSymbol=false
            },
            updataReader(){
                let temp=new FormData()
                temp.set('reader.name',this.updataNewReader.name)
                temp.set('reader.phone',this.updataNewReader.phone)
                temp.set('reader.email',this.updataNewReader.email)
                temp.set('reader.flag',this.updataNewReader.flag)
                temp.set('reader.account',JSON.parse(localStorage.getItem('user')).account)
                axios.post('/reader/updataReader',temp).then(response=>{
                    if(response.data.code===1){
                        alert('修改成功')
                        // location.reload()
                    }else alert('修改失败')
                })
            },
            returnBookTwo(tempBorrow){
                let temp = new FormData()
                temp.set('borrow.bookIndex', tempBorrow.bookIndex)
                temp.set('borrow.readerIndex', tempBorrow.readerIndex)
                axios.post('/borrow/returnBook', temp).then(response => {
                    if (response.data.code === 1) {
                        window.alert('归还成功')
                        location.reload()
                    } else window.alert('归还失败')
                })
            }
        },
        mounted() {
            if (localStorage.getItem('user') === null) {
                location.href = 'login.jsp'
            } else {
                axios.get("/book/getAllBook").then(response => {
                    this.bookList = response.data.data
                    this.filterBookList = this.bookList
                })
                if (this.userType) {
                    axios.get("/borrow/getAllBorrow").then(response => {
                        this.BorrowList = response.data.data
                    })
                    axios.get("/reader/getAllReader").then(response => {
                        this.readerList = response.data.data
                        this.filterReaderList = this.readerList
                    })
                } else {
                    axios.get("/borrow/getAllMyBorrow?account="+JSON.parse(localStorage.getItem('user')).account).then(response => {
                        this.myBorrowList = response.data.data
                        this.filterMyBorrowList = this.myBorrowList
                    })
                    axios.get("/book/getAllAvaBook").then(response => {
                        this.availableForBorrow = response.data.data
                        this.filterAvailableForBorrow = this.availableForBorrow
                    })

                }
            }
        },
    }).use(ElementPlus).mount('#place')
</script>
<style>
    .place {
        height: 100%;
        width: 100%;
    }

    .el-menu-demo {
        width: 100%;
        height: 100%;
        background-color: bisque;
        display: flex;
        align-items: center;
    }

    .el-menu--horizontal > .el-menu-item:nth-child(1) {
        margin-right: auto;
        width: 100%;
    }

    .el-menu-vertical-demo:not(.el-menu--collapse) {
        width: 100%;
        min-height: 400px;
        background-color: aquamarine;
    }

    p {
        font-size: 50px;
        font-style: italic;
        font-family: "LiSu", serif;
    }

    img {
        height: 75%;
        margin-left: 3%;
        margin-right: 5%;
    }
</style>
</html>
