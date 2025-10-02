const fs = require('fs');

console.log('开始修复declaration.js的所有语法错误...');

// 读取文件
let content = fs.readFileSync('declaration.js', 'utf8');

// 修复所有的语法错误
console.log('1. 修复字符串引号错误...');
content = content.replace(/mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝?,/g, "mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝?',");
content = content.replace(/mainGoods: '绾虹粐鍝併€侀瀷绫?,/g, "mainGoods: '绾虹粐鍝併€侀瀷绫?',");
content = content.replace(/mainGoods: '椋熷搧銆侀ギ鏂?,/g, "mainGoods: '椋熷搧銆侀ギ鏂?',");

console.log('2. 修复注释与代码混合的问题...');
// 修复 "// 鐘舵€?  const" 格式的错误
content = content.replace(/\/\/ 鐘舵€\?\s+const/g, '// 鐘舵€?\n  const');
content = content.replace(/\/\/ 鑾峰彇鐢虫姤鍗曞垪琛\?\s+const/g, '// 鑾峰彇鐢虫姤鍗曞垪琛?\n  const');
content = content.replace(/\/\/ 鑾峰彇鐢虫姤鍗曡鎯\?\s+const/g, '// 鑾峰彇鐢虫姤鍗曡鎯?\n  const');
content = content.replace(/\/\/ 鎻愪氦鐢虫姤鍗\?\s+const/g, '// 鎻愪氦鐢虫姤鍗?\n  const');
content = content.replace(/\/\/ 淇濆瓨涓烘ā鏉\?\s+const/g, '// 淇濆瓨涓烘ā鏉?\n  const');
content = content.replace(/\/\/ 娓呯┖褰撳墠鐢虫姤鍗\?\s+const/g, '// 娓呯┖褰撳墠鐢虫姤鍗?\n  const');
content = content.replace(/\/\/ 鍒濆鍖栨柊鐢虫姤鍗\?\s+const/g, '// 鍒濆鍖栨柊鐢虫姤鍗?\n  const');

// 修复特殊的注释问题
content = content.replace(/\/\/ 鍘熷API璋冪敤浠ｇ爜锛堝綋鍚庣API鍑嗗濂藉悗鍚敤锛\?\s+\/\/ const/g, 
  '// 鍘熷API璋冪敤浠ｇ爜锛堝綋鍚庣API鍑嗗濂藉悗鍚敤锛?\n      // const');

content = content.replace(/\/\/ 鏇存柊褰撳墠鐢虫姤鍗曟暟鎹\?\s+if/g, 
  '// 鏇存柊褰撳墠鐢虫姤鍗曟暟鎹?\n        if');

content = content.replace(/\/\/ 鏍告斁鍗曡〃澶\?\s+dischargedNo/g, 
  '// 鏍告斁鍗曡〃澶?\n      dischargedNo');

console.log('3. 写入修复后的文件...');
fs.writeFileSync('declaration.js', content);

console.log('所有语法错误修复完成！');

// 验证语法
const { exec } = require('child_process');
exec('node -c declaration.js', (error, stdout, stderr) => {
  if (error) {
    console.error('语法检查失败:', error.message);
    console.error('错误输出:', stderr);
  } else {
    console.log('语法检查通过！');
  }
});