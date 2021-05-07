<template>
	<view class="message-content">
			<view class="top">
				<image :src="messageData.avatar" mode="" class="top-avatar"></image>
				<view class="top-main">
					<text class="top-name">{{messageData.name}}</text>
					<text class="top-time">{{messageData.time | filtedate}}</text>
				</view>
				<text v-show="messageData.isFollow==1" class="top-follow" @click.stop="follow(messageData.id)">关注</text>
				<text v-show="messageData.isFollow==0" class="top-follow" @click.stop="follow(messageData.id)">已关注</text>
			</view>
			<view class="message">
				{{messageData.message}}
			</view>
			<view class="message-img-content">
				<image :src="item" mode="" v-for="(item,index) in messageData.img" :key="index" class="message-img" @click.stop="previewImage(messageData.img,index)"></image>
			</view>
			<view class="comment">
				<image :src="avatar" mode="" class="comment-img"></image>
				<input type="text" v-model="comment" placeholder="您可以在此输入评论" class="comment-input"/>
			</view>
			<view class="bottom">
				<view class="bottom-item">
					<image src="../../static/image/comment.png" mode="" class="bottom-icon"></image>
					<text class="bottom-num">{{messageData.comment}}</text>
				</view>
				<view class="bottom-item">
					<image src="../../static/image/like.png" mode="" class="bottom-icon" v-show="messageData.isLike==1"></image>
					<image src="../../static/image/unlike.png" mode="" class="bottom-icon" v-show="messageData.isLike==0"></image>
					<text class="bottom-num">{{messageData.like}}</text>
				</view>
			</view>
	</view>
</template>

<script>
	import { formatDate } from '@/static/js/dateFormat.js';
export default {
	props: {
		messageData: {
			type: Object,
			default: {}
		},
		avatar: {
			type: String,
			default: ''
		}
	},
	data() {
		return {
			comment:''
		};
	},
	methods: {
		follow(id){
			this.$emit('change-follow',id);
		},
		// 图片预览
		previewImage(urls,index){
			uni.previewImage({urls: urls,current:index})
		}
	},
		filters: {
			filtedate: function(date) {
				let t = new Date(date);
				console.log(t);
				return formatDate(t, 1);
			}
		}
};
</script>

<style lang="scss" scoped>
.message-content{
		.top{
			height: 100rpx;
			display: flex;
			align-items: center;
			justify-content: space-between;
			.top-avatar{
				width: 80rpx;
				height: 80rpx;
				border-radius: 50%;
			}
			.top-main{
				width: 450rpx;
				height: 80rpx;
				display: flex;
				flex-direction: column;
				justify-content: space-between;
				white-space: nowrap;
				overflow: hidden;
				.top-name{
					font-weight: bold;
				}
				.top-time{
					color: #888;
					font-size: 12px;
				}
			}
			.top-follow	{
				width: 114rpx;
				height: 46rpx;
				line-height: 46rpx;
				background-color: $theme-color;
				border-radius: 50px;
				text-align: center;
				font-size: 12px;
			}
		}
		.message{
			margin-bottom: 20rpx;
			margin-top: 10rpx;
		}
		.message-img-content{
			margin-bottom: 20rpx;
			.message-img{
				width: 220rpx;
				height: 220rpx;
				margin-right: 10rpx;
			}
		}
		.comment{
			display: flex;
			align-items: center;
			.comment-img{
				width: 70rpx;
				height: 70rpx;
				border-radius: 50%;
				margin-right: 20rpx;
			}
			.comment-input{
				width: 550rpx;
				height: 50rpx;
				padding: 6rpx 26rpx;
				background-color: #eee;
				border-radius: 30px;
				font-size: 13px;
			}
		}
		.bottom{
			height: 60rpx;
			display: flex;
			border-top: 1px solid #ccc;
			border-bottom: 1px solid #ccc;
			margin-top: 20rpx;
			.bottom-item{
				width: 50%;
				height: 100%;
				display: flex;
				justify-content: center;
				align-items: center;
				.bottom-icon{
					width: 34rpx;
					height: 34rpx;
					margin-right: 10rpx;
				}
				.bottom-num{
					font-size: 13px;
				}
				&:first-child{
					border-right: 1px solid #ccc;
				}
			}
		}
}
</style>

