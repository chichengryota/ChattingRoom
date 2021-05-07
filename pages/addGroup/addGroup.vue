<template>
	<view>
		<navbar :type="3" :showConfirm="false" title="创建群聊"></navbar>
		<view class="add-group">
			<view class="add-group-top">
				<u-upload :action="action" :file-list="fileList"></u-upload>
				<input type="text" v-model="groupName" placeholder="请输入群聊名称" class="add-group-top-input"/>
			</view>
			<scroll-view class="add-group-user">
				<view class="add-group-user-title">用户</view>
				<u-checkbox-group wrap>
					<u-checkbox @change="checkboxChange" size="46" shape="circle" active-color="rgb(133, 203, 248)" v-model="item.checked" v-for="(item, index) in userList" :key="index" :name="item.name">
						<view class="add-group-user-list">
							<image :src="item.avatar" mode="" class="user-img"></image>
							<text class="user-name">{{ item.name }}</text>
						</view>
					</u-checkbox>
				</u-checkbox-group>
			</scroll-view>
			<view class="add-group-button">
				<button type="default" class="create-button">创建({{checkedList.length}})</button>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			action: 'http://www.example.com/upload',
			fileList: [],
			userList: [
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false },
				{ name: '哈哈哈', avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg', checked: false }
			],
			checkedList:[],
			groupName: ''
		};
	},
	methods: {
		// 选中某个复选框时，由checkbox时触发
				checkboxChange(e) {
					//console.log(e);
				},
	}
};
</script>

<style lang="scss" scoped>
.add-group{
	.add-group-top{
		width: 100%;
		height: 450rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-evenly;
		align-items: center;
		.add-group-top-input{
			width: 680rpx;
			height: 90rpx;
			border-radius: 30px;
			background-color: #eee;
			text-align: center;
		}
	}
	.add-group-user{
		width: 100%;
		padding: 0 30rpx;
		padding-bottom: 150rpx;
		.add-group-user-title{
			font-size: 20px;
			font-weight: bold;
		}
		.add-group-user-list{
			display: flex;
			align-items: center;
			height: 130rpx;
			.user-img{
				width: 76rpx;
				height: 76rpx;
				border-radius: 8px;
				margin-left: 20rpx;
				margin-right: 30rpx;
			}
			.user-name{
				font-size: 16px;
			}
		}
	}
	.add-group-button{
		position: fixed;
		bottom: 0;
		height: 140rpx;
		width: 100%;
		border-top: 1px solid #ccc;
		background-color: #fff;
		.create-button{
			width: 700rpx;
			margin: 10rpx auto;
			height: 80rpx;
			line-height: 80rpx;
			&::after{
				border: none;
			}
			background-color: $theme-color;
		}
	}
}
</style>
