<template>
	<view>
		<navbar :type="1"></navbar>
		<scroll-view scroll-y="true" >
			<view class="messageContent" v-if="messageList.length!==0">
				<u-swipe-action :show="item.show" :index="index"
							v-for="(item, index) in messageList" :key="index" 
							 @click="deleteClick" @open="open" @content-click="goChat(index,item.id)"
							:options="options" btn-width="140"
						>
						<view class="messageItem" :class="active==index?'active':''">
							<view class="messageItem-left">
								<image :src="item.avatar" class="messageItem-img"></image>
								<u-badge type="error" :count="item.count" :offset="[-10,-10]"></u-badge>
							</view>
							<view class="messageItem-main">
								<view class="messageItem-name">
									{{item.name}}
								</view>
								<view class="messageItem-message">
									{{item.message}}
								</view>
							</view>
							<view class="messageItem-time">{{item.time | filtedate}}</view>
						</view>
					</u-swipe-action>
			</view>
			<view class="noMessage" v-else>
				<text class="title">一个好友都没有</text>
				<button type="default" class="search" @click="goSearch">搜索好友</button>
			</view>
		</scroll-view>
	</view>
</template>

<script>
	import { formatDate } from '@/static/js/dateFormat.js';
	export default {
		data() {
			return {
				messageList:[{
					id: 1,
					count: 2,
					avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t01dfe78c9e02a650c3.jpg',
					name: '李元芳',
					message: '我叫李元芳，很高兴认识你',
					time: 1614689655857
				},{
					id: 5,
					count: 1,
					avatar: 'http://browser9.qhimg.com/bdm/800_450_85/t01e1a2d6222d272b78.jpg',
					name: '玛卡莎',
					message: '你好扣你急哇',
					time: 1614551181585
				},{
					id: 6,
					count: 4,
					avatar: 'http://browser9.qhimg.com/bdm/640_400_85/t01287bd180d28865b9.jpg',
					name: '斯巴达',
					message: '好兄弟帮帮我',
					time: 161431161100
				}],
				active:-1,
				show: false,
				// 左滑取消框内数据
				options: [
					{
						text: '删除',
						style: {
							backgroundColor: '#dd524d'
						}
					}
				],
			};
		},
		onPullDownRefresh() {
			setTimeout(function() {
				uni.stopPullDownRefresh(); //停止下拉刷新动画
			}, 1000);
		},
		methods:{
			back(){
				uni.navigateBack();
			},
			goChat(index,id){
				this.active = index;
				uni.$u.route('/pages/chat/chat', { id: id });
			},
			goSearch(){
				uni.navigateTo({
					url:'/pages/search/search'
				})
			},
			// 点击确定左滑删除
			deleteClick(index, index1) {
				this.messageList.splice(index, 1);
				this.$chat.alert(`删除了第${index}个课程`,'none');
			},
			// 如果打开一个的时候，不需要关闭其他，则无需实现本方法
			open(index) {
				// 先将正在被操作的swipeAction标记为打开状态，否则由于props的特性限制，
				// 原本为'false'，再次设置为'false'会无效
				this.messageList[index].show = true;
				this.messageList.map((val, idx) => {
					if(index != idx) this.messageList[idx].show = false;
				})
			}
		},
		filters: {
			filtedate: function(date) {
				let t = new Date(date);
				return formatDate(t, 1);
			}
		}
	}
</script>

<style lang="scss">
.messageContent{
	padding: 20rpx 0;
	.messageItem{
		width: 100%;
		height: 150rpx;
		padding: 0 30rpx;
		box-sizing: border-box;
		display: flex;
		align-items: center;
		justify-content: space-between;
		.messageItem-left{
			position: relative;
			.messageItem-img{
				width: 100rpx;
				height: 100rpx;
				border-radius: 10px;
			}
		}
		.messageItem-main{
			width: 430rpx;
			height: 90rpx;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			white-space: nowrap;
			overflow: hidden;
			.messageItem-name{
				font-size: 16px;
				font-weight: bold;
			}
			.messageItem-message{
				font-size: 14px;
			}
		}
		.messageItem-time{
			width: 112rpx;
			text-align: right;
			font-size: 12px;
			color: #999;
			margin-bottom: 40rpx;
		}
	}
	.active{
		background-color: #eee;
	}
}
.noMessage{
	display: flex;
	height: 70vh;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	.title{
		margin-bottom: 50rpx;
		color: #888;
		font-size: 14px;
	}
	.search{
		width: 220rpx;
		height: 90rpx;
		line-height: 90rpx;
		border-radius: 50px;
		font-size: 15px;
		color: #fff;
		font-weight: bold;
		background-color: $theme-color;
		&:after{
			border: none;
		}
	}
}
</style>
